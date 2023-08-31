from sqlalchemy import create_engine, Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship, sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import textwrap
from datetime import datetime

Base = declarative_base()
engine = create_engine('sqlite:///banco_de_dados.db')
Session = sessionmaker(bind=engine)
session = Session()

class Cliente(Base):
    __tablename__ = 'clientes'
    id = Column(Integer, primary_key=True)
    endereco = Column(String)
    contas = relationship("Conta", back_populates="cliente")

class PessoaFisica(Cliente):
    __tablename__ = 'pessoas_fisicas'
    id = Column(Integer, ForeignKey('clientes.id'), primary_key=True)
    nome = Column(String)
    data_nascimento = Column(String)
    cpf = Column(String)

class Conta(Base):
    __tablename__ = 'contas'
    id = Column(Integer, primary_key=True)
    saldo = Column(Integer, default=0)
    numero = Column(String)
    agencia = Column(String, default="0001")
    cliente_id = Column(Integer, ForeignKey('clientes.id'))
    cliente = relationship("Cliente", back_populates="contas")
    senha = Column(String)

class ContaCorrente(Conta):
    __tablename__ = 'contas_correntes'
    id = Column(Integer, ForeignKey('contas.id'), primary_key=True)
    limite = Column(Integer, default=500)
    limite_saques = Column(Integer, default=3)
    senha = Column(String)

class Historico(Base):
    __tablename__ = 'historicos'
    id = Column(Integer, primary_key=True)
    conta_id = Column(Integer, ForeignKey('contas.id'))
    transacoes = relationship("Transacao", back_populates="historico")

class Transacao(Base):
    __tablename__ = 'transacoes'
    id = Column(Integer, primary_key=True)
    tipo = Column(String)
    valor = Column(Integer)
    data = Column(String)
    historico_id = Column(Integer, ForeignKey('historicos.id'))
    historico = relationship("Historico", back_populates="transacoes")

class Deposito(Transacao):
    __tablename__ = 'depositos'
    id = Column(Integer, ForeignKey('transacoes.id'), primary_key=True)

    def registrar(self, conta):
        """
        Registra o depósito na conta e adiciona a transação ao histórico.
        """
        sucesso_transacao = conta.depositar(self.valor)

        if sucesso_transacao:
            historico = Historico(conta_id=conta.id)
            session.add(historico)
            self.historico = historico
            session.commit()

class Saque(Transacao):
    __tablename__ = 'saques'
    id = Column(Integer, ForeignKey('transacoes.id'), primary_key=True)

    def registrar(self, conta):
        """
        Registra o saque na conta e adiciona a transação ao histórico.
        """
        sucesso_transacao = conta.sacar(self.valor)

        if sucesso_transacao:
            historico = Historico(conta_id=conta.id)
            session.add(historico)
            self.historico = historico
            session.commit()

def exibir_extrato(session, clientes):
    """
    Exibe o extrato bancário de um cliente.
    """
    cpf = input("Informe o CPF do cliente: ")
    cliente = session.query(PessoaFisica).filter_by(cpf=cpf).first()

    if not cliente:
        print("\n@@@ Cliente não encontrado! @@@")
        return

    conta = cliente.contas[0]  # Supondo que o cliente tem apenas uma conta

    print("\n================ EXTRATO ================")
    historico = session.query(Historico).filter_by(conta_id=conta.id).first()

    if historico:
        transacoes = historico.transacoes

        for transacao in transacoes:
            print(f"\n{transacao.tipo}:\n\tValor: R$ {transacao.valor:.2f}")
            print(f"\tData: {transacao.data}")
    else:
        print("Não foram realizadas movimentações.")

    print(f"\nSaldo:\n\tR$ {conta.saldo:.2f}")
    print("==========================================")

def criar_cliente(clientes):
    """
    Cria um novo cliente.
    """
    cpf = input("Informe o CPF (somente número): ")
    cliente = filtrar_cliente(cpf, clientes)

    if cliente:
        print("\n@@@ Já existe cliente com esse CPF! @@@")
        return

    nome = input("Informe o nome completo: ")
    data_nascimento = input("Informe a data de nascimento (dd-mm-aaaa): ")
    endereco = input("Informe o endereço (logradouro, nro - bairro - cidade/sigla estado): ")

    cliente = PessoaFisica(nome=nome, data_nascimento=data_nascimento, cpf=cpf, endereco=endereco)

    clientes.append(cliente)

    print("\n=== Cliente criado com sucesso! ===")

def criar_conta(numero_conta, clientes, contas):
    """
    Cria uma nova conta para um cliente.
    """
    cpf = input("Informe o CPF do cliente: ")
    cliente = filtrar_cliente(cpf, clientes)

    if not cliente:
        print("\n@@@ Cliente não encontrado, fluxo de criação de conta encerrado! @@@")
        return

    senha = input("Defina a senha da conta: ")  # Solicita a senha ao criar a conta
    conta = ContaCorrente(cliente=cliente, numero=numero_conta)
    conta.senha = senha  # Define a senha da conta
    contas.append(conta)
    cliente.contas.append(conta)
    print("\n=== Conta criada com sucesso! ===")

def listar_contas(contas):
    """
    Lista todas as contas existentes.
    """
    for conta in contas:
        print("=" * 100)
        print(textwrap.dedent(str(conta)))

def menu():
    """
    Exibe o menu principal e retorna a opção escolhida pelo usuário.
    """
    menu = """\n
    ================ MENU ================
    [d]\tDepositar
    [s]\tSacar
    [e]\tExtrato
    [nc]\tNova conta
    [lc]\tListar contas
    [nu]\tNovo usuário
    [q]\tSair
    => """
    return input(textwrap.dedent(menu))

def depositar(clientes):
    """
    Realiza a operação de depósito.
    """
    cpf = input("Informe o CPF do cliente: ")
    cliente = session.query(PessoaFisica).filter_by(cpf=cpf).first()

    if not cliente:
        print("\n@@@ Cliente não encontrado! @@@")
        return

    valor = float(input("Informe o valor do depósito: "))
    conta = cliente.contas[0]  # Supondo que o cliente tem apenas uma conta

    transacao = Deposito(valor=valor)
    transacao.registrar(conta)
    session.commit()
def sacar(clientes):
    """
    Realiza a operação de saque.
    """
    cpf = input("Informe o CPF do cliente: ")
    cliente = session.query(PessoaFisica).filter_by(cpf=cpf).first()

    if not cliente:
        print("\n@@@ Cliente não encontrado! @@@")
        return

    valor = float(input("Informe o valor do saque: "))
    conta = cliente.contas[0]  # Supondo que o cliente tem apenas uma conta

    transacao = Saque(valor=valor)
    transacao.registrar(conta)
    session.commit()

def filtrar_cliente(cpf, clientes):
    """
    Filtra um cliente na lista pelo CPF.
    """
    for cliente in clientes:
        if isinstance(cliente, PessoaFisica) and cliente.cpf == cpf:
            return cliente
    return None


def main():
    """
    Função principal que controla o fluxo do programa.
    """
    clientes = []
    contas = []

    while True:
        opcao = menu()

        if opcao == "d":
            depositar(clientes)

        elif opcao == "s":
            sacar(clientes)

        elif opcao == "e":
            exibir_extrato(session, clientes)

        elif opcao == "nu":
            criar_cliente(clientes)

        elif opcao == "nc":
            numero_conta = len(contas) + 1
            criar_conta(numero_conta, clientes, contas)

        elif opcao == "lc":
            listar_contas(contas)

        elif opcao == "q":
            break

        else:
            print("\n@@@ Operação inválida, por favor selecione novamente a operação desejada. @@@")
    session.close()

if __name__ == "__main__":
    Base.metadata.create_all(engine)
    main()








