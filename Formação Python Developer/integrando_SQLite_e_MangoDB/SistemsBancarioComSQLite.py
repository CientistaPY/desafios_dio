from sqlalchemy import create_engine, Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship, sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime

Base = declarative_base()
engine = create_engine('sqlite:///banco_de_dados.db')
Session = sessionmaker(bind=engine)
session = Session()

class Cliente(Base):
    """
    Tabela de clientes.
    """
    __tablename__ = 'clientes'
    id = Column(Integer, primary_key=True)
    tipo = Column(String)
    cpf_cnpj = Column(String)
    nome = Column(String)  # Adicionei uma coluna para o nome do cliente
    endereco = Column(String)
    contas = relationship("Conta", back_populates="cliente")
class Conta(Base):
    """
    Tabela de contas.
    """
    __tablename__ = 'contas'
    id = Column(Integer, primary_key=True)
    saldo = Column(Integer, default=0)
    numero = Column(String)
    agencia = Column(String, default="0001")
    tipo = Column(String)  # Adicionei uma coluna para o tipo de conta (corrente ou poupança)
    cliente_id = Column(Integer, ForeignKey('clientes.id'))
    cliente = relationship("Cliente", back_populates="contas")
    senha = Column(String)

class Historico(Base):
    """
    Tabela de históricos.
    """
    __tablename__ = 'historicos'
    id = Column(Integer, primary_key=True)
    conta_id = Column(Integer, ForeignKey('contas.id'))
    tipo_transacao = Column(String)  # Adicionei uma coluna para o tipo de transação (Depósito ou Saque)
    valor = Column(Integer)
    data = Column(String)

Base.metadata.create_all(engine)

def extrato(cliente):
    """
    Exibe o extrato bancário de um cliente.
    """
    contas_cliente = cliente.contas

    for conta in contas_cliente:
        print(f"\n========== Extrato da Conta {conta.numero} ==========")
        historicos = session.query(Historico).filter_by(conta_id=conta.id).all()

        if historicos:
            for historico in historicos:
                print(f"Data: {historico.data}")
                print(f"Tipo de Transação: {historico.tipo_transacao}")
                print(f"Valor: R$ {historico.valor:.2f}")
                print("=" * 40)
        else:
            print("Não foram realizadas movimentações.")

def criar_cliente():
    """
    Cria um novo cliente.
    """
    tipo_cliente = input("Informe o tipo de Cadstro de Pessoa (CPF ou CPNJ): ").lower()
    cpf_cnpj = input(f"Informe o {tipo_cliente.upper()} (somente número): ")
    cliente = session.query(Cliente).filter_by(tipo=tipo_cliente, cpf_cnpj=cpf_cnpj).first()

    if cliente:
        print("\n@@@ Já existe cliente com esse CPF/CNPJ! @@@")
        return

    nome = input("Informe o nome completo: ")  # Adicione esta linha para pegar o nome
    data_nascimento = input("Informe a data de nascimento (dd-mm-aaaa): ")
    endereco = input("Informe o endereço (logradouro, nro - bairro - cidade/sigla estado): ")

    cliente = Cliente(tipo=tipo_cliente, cpf_cnpj=cpf_cnpj, nome=nome, endereco=endereco)  # Adicione nome
    session.add(cliente)
    session.commit()
    print("\n=== Cliente criado com sucesso! ===")

def criar_conta(cliente):
    """
    Cria uma nova conta para um cliente.
    """
    numero_conta = len(cliente.contas) + 1
    senha = input("Defina a senha da conta: ")
    agencia = input("Defina a agencia da conta: ")
    tipo_conta = input("Informe o tipo da conta (cc=corrente ou cp=poupança): ").lower()

    conta = Conta(saldo=0, numero=numero_conta, agencia=agencia, tipo=tipo_conta, cliente=cliente, senha=senha)
    session.add(conta)
    session.commit()
    print("\n=== Conta criada com sucesso! ===")

def registrar_transacao(conta, tipo_transacao, valor):
    """
    Registra a transação no histórico.
    """
    historico = Historico(conta_id=conta.id, tipo_transacao=tipo_transacao, valor=valor,
                          data=datetime.now().strftime('%d-%m-%Y'))
    session.add(historico)
    session.commit()

def depositar(cliente):
    """
    Realiza a operação de depósito.
    """
    valor = float(input("Informe o valor do depósito: "))
    conta = cliente.contas[0]

    conta.saldo += valor
    registrar_transacao(conta, "Depósito", valor)
    print("\n=== Depósito realizado com sucesso! ===")

def sacar(cliente):
    """
    Realiza a operação de saque.
    """
    senha = input("Informe a senha da conta: ")
    conta = cliente.contas[0]

    if conta.senha == senha:
        valor = float(input("Informe o valor do saque: "))

        if conta.saldo >= valor:
            conta.saldo -= valor
            registrar_transacao(conta, "Saque", valor)
            print("\n=== Saque realizado com sucesso! ===")
        else:
            print("\n@@@ Saldo insuficiente! @@@")
    else:
        print("\n@@@ Senha incorreta! @@@")

def listar_clientes():
    """
    Lista informações dos clientes juntamente com suas contas.
    """
    clientes_contas = session.query(Cliente, Conta).filter(Cliente.id == Conta.cliente_id).all()

    for cliente, conta in clientes_contas:
        print("\n===== Informações do Cliente =====")
        print(f"Nome: {cliente.nome}")
        print(f"CPF/CNPJ: {cliente.cpf_cnpj}")
        print("Conta:")
        print(f"    Tipo: {conta.tipo}")
        print(f"    Número: {conta.numero}")
        print(f"    Agência: {conta.agencia}")
        print(f"    Saldo: R$ {conta.saldo:.2f}")
        print("=" * 40)
def main():
    while True:
        opcao = menu()

        if opcao == "nu":
            criar_cliente()

        elif opcao == "nc":
            cpf_cnpj = input("Informe o CPF (PF) ou CNPJ (PJ) do cliente: ")
            tipo_cliente = input("Informe o tipo de cliente (PF ou PJ): ").lower()

            cliente = session.query(Cliente).filter_by(tipo=tipo_cliente, cpf_cnpj=cpf_cnpj).first()

            if not cliente:
                print("\n@@@ Cliente não encontrado! @@@")
                continue

            criar_conta(cliente)

        elif opcao == "d":
            cpf_cnpj = input("Informe o CPF (PF) ou CNPJ (PJ) do cliente: ")

            cliente = session.query(Cliente).filter_by(cpf_cnpj=cpf_cnpj).first()

            if not cliente:
                print("\n@@@ Cliente não encontrado! @@@")
                continue

            depositar(cliente)

        elif opcao == "s":
            cpf_cnpj = input("Informe o CPF (PF) ou CNPJ (PJ) do cliente: ")

            tipo_cliente = input("Informe o tipo de cliente (PF ou PJ): ").lower()

            cliente = session.query(Cliente).filter_by(tipo=tipo_cliente, cpf_cnpj=cpf_cnpj).first()

            if not cliente:
                print("\n@@@ Cliente não encontrado! @@@")
                continue

            sacar(cliente)

        elif opcao == "e":
            cpf_cnpj = input("Informe o CPF (PF) ou CNPJ (PJ) do cliente: ")

            cliente = session.query(Cliente).filter_by(cpf_cnpj=cpf_cnpj).first()

            if not cliente:
                print("\n@@@ Cliente não encontrado! @@@")
                continue

            extrato(cliente)
        elif opcao == "lc":
            listar_clientes()

        elif opcao == "q":
            break

def menu():
    """
    Exibe o menu principal e retorna a opção escolhida pelo usuário.
    """
    menu = """\n
    ================ MENU ================
    [nc] Nova conta
    [nu] Novo usuário
    [d]  Depositar
    [s]  Sacar
    [e]  Extrato
    [lc] Listar Clientes
    [q]  Sair
    => """
    return input(menu)

if __name__ == "__main__":
    main()
