from pymongo import MongoClient
from datetime import datetime
from pymongo.server_api import ServerApi

# Conectar ao servidor do MongoDB

client = MongoClient("mongodb+srv://luiscarlos:1234@cluster0.wko7a6z.mongodb.net/?retryWrites=true&w=majority")
  # Substitua pela URL de conexão do MEU cluster MongoDB

# Criar/obter um banco de dados
db = client["banco_de_dados_mongodb"]  #  nome do banco de dados desejado

# Criar/obter uma coleção "clientes"
clientes_collection = db["clientes"]


class Cliente:
    def __init__(self, tipo, cpf_cnpj, nome, endereco):
        self.tipo = tipo
        self.cpf_cnpj = cpf_cnpj
        self.nome = nome
        self.endereco = endereco
        self.contas = []

    def save(self):
        # Inserir o documento do cliente na coleção "clientes"
        clientes_collection.insert_one({
            "tipo": self.tipo,
            "cpf_cnpj": self.cpf_cnpj,
            "nome": self.nome,
            "endereco": self.endereco,
            "contas": self.contas
        })


# Criar/obter uma coleção "contas"
contas_collection = db["contas"]


class Conta:
    def __init__(self, saldo, numero, agencia, tipo, senha):
        self.saldo = saldo
        self.numero = numero
        self.agencia = agencia
        self.tipo = tipo
        self.senha = senha

    def save(self):
        # Inserir o documento da conta na coleção "contas"
        contas_collection.insert_one({
            "saldo": self.saldo,
            "numero": self.numero,
            "agencia": self.agencia,
            "tipo": self.tipo,
            "senha": self.senha
        })

# Importar a classe Historico
class Historico:
    def __init__(self, tipo_transacao, valor, data):
        self.tipo_transacao = tipo_transacao
        self.valor = valor
        self.data = data

# Função para exibir o menu principal e obter a opção do usuário
def menu():
    menu_text = """\n
    ================ MENU ================
    [nc] Nova conta
    [nu] Novo usuário
    [d]  Depositar
    [s]  Sacar
    [e]  Extrato
    [lc] Listar Clientes
    [q]  Sair
    => """
    return input(menu_text)


# Funções para as operações no banco MongoDB
# Função para registrar transação
def registrar_transacao(conta, tipo_transacao, valor):
    """
    Registra a transação no histórico.
    """
    historico = Historico(tipo_transacao=tipo_transacao, valor=valor, data=datetime.now().strftime('%d-%m-%Y'))
    conta.historicos.append(historico)

    # Atualizar o documento da conta no MongoDB
    contas_collection.update_one({"numero": conta.numero}, {"$set": conta.__dict__})


# Função para depositar
def depositar(cliente):
    """
    Realiza a operação de depósito.
    """
    valor = float(input("Informe o valor do depósito: "))

    numero_conta_atual = cliente["conta_atual"]
    conta_data = contas_collection.find_one({"numero": numero_conta_atual})

    if conta_data:
        del conta_data["_id"]  # Remover o campo _id do dicionário
        conta = Conta(**conta_data)
        conta.saldo += valor
        registrar_transacao(conta, "Depósito", valor)

        # Atualizar o documento da conta no MongoDB
        contas_collection.update_one({"numero": numero_conta_atual}, {"$set": conta.__dict__})
        registrar_transacao(conta_data, "Depósito", valor)
        print("\n=== Depósito realizado com sucesso! ===")
    else:
        print("\n@@@ Conta não encontrada! @@@")





# Função para sacar
def sacar(cliente):
    """
    Realiza a operação de saque.
    """
    senha = input("Informe a senha da conta: ")
    conta = cliente["contas"][0]  # Ajuste aqui para pegar a primeira conta do cliente

    if conta["senha"] == senha:
        valor = float(input("Informe o valor do saque: "))

        if conta["saldo"] >= valor:
            conta["saldo"] -= valor
            registrar_transacao(conta, "Saque", valor)
            print("\n=== Saque realizado com sucesso! ===")
        else:
            print("\n@@@ Saldo insuficiente! @@@")
    else:
        print("\n@@@ Senha incorreta! @@@")

def extrato(cliente):
    """
    Exibe o extrato bancário de um cliente.
    """
    print(f"\n========== Extrato do Cliente {cliente.nome} ==========")

    for conta in cliente.contas:
        historicos = contas_collection.find_one({"numero": conta.numero})["historicos"]

        if historicos:
            for historico in historicos:
                print(f"Data: {historico['data']}")
                print(f"Tipo de Transação: {historico['tipo_transacao']}")
                print(f"Valor: R$ {historico['valor']:.2f}")
                print("=" * 40)
        else:
            print("Não foram realizadas movimentações.")


def criar_cliente():
    """
    Cria um novo cliente.
    """
    tipo_cliente = input("Informe o tipo de Cadastro de Pessoa (CPF ou CNPJ): ").lower()
    cpf_cnpj = input(f"Informe o {tipo_cliente.upper()} (somente número): ")
    cliente = clientes_collection.find_one({"tipo": tipo_cliente, "cpf_cnpj": cpf_cnpj})

    if cliente:
        print("\n@@@ Já existe cliente com esse CPF/CNPJ! @@@")
        return

    nome = input("Informe o nome completo: ")
    endereco = input("Informe o endereço: ")

    cliente_data = {
        "tipo": tipo_cliente,
        "cpf_cnpj": cpf_cnpj,
        "nome": nome,
        "endereco": endereco,
        "conta_atual": None,
        "contas": []  # Inicializa a lista de contas
    }

    result = clientes_collection.insert_one(cliente_data)

    if result.inserted_id:
        print("\n=== Cliente criado com sucesso! ===")
    else:
        print("\n@@@ Ocorreu um erro ao criar o cliente. @@@")



def criar_conta(cliente):
    """
    Cria uma nova conta para um cliente.
    """
    numero_conta = len(cliente["contas"]) + 1
    senha = input("Defina a senha da conta: ")
    agencia = input("Defina a agência da conta: ")
    tipo_conta = input("Informe o tipo da conta (cc=corrente ou cp=poupança): ").lower()

    conta = Conta(saldo=0, numero=numero_conta, agencia=agencia, tipo=tipo_conta, senha=senha)
    conta.save()  # Salva a conta no MongoDB
    cliente["contas"].append(conta.__dict__)  # Adiciona a conta à lista de contas do cliente

    # Atualiza o documento do cliente no MongoDB com a nova lista de contas
    clientes_collection.update_one({"_id": cliente["_id"]}, {"$set": {"contas": cliente["contas"]}})

    print("\n=== Conta criada com sucesso! ===")


# Função principal
def main():
    while True:
        opcao = menu()

        if opcao == "nu":
            criar_cliente()

        elif opcao == "nc":
            cpf_cnpj = input("Informe o CPF (PF) ou CNPJ (PJ) do cliente: ")
            tipo_cliente = input("Informe o tipo de cliente (PF ou PJ): ").lower()

            cliente = clientes_collection.find_one({"cpf_cnpj": cpf_cnpj, "tipo": tipo_cliente})

            if not cliente:
                print("\n@@@ Cliente não encontrado! @@@")
                continue

            criar_conta(cliente)

        elif opcao == "d":
            cpf_cnpj = input("Informe o CPF (PF) ou CNPJ (PJ) do cliente: ")

            cliente = clientes_collection.find_one({"cpf_cnpj": cpf_cnpj})

            if not cliente:
                print("\n@@@ Cliente não encontrado! @@@")
                continue

            depositar(cliente)

        elif opcao == "s":
            cpf_cnpj = input("Informe o CPF (PF) ou CNPJ (PJ) do cliente: ")

            cliente = clientes_collection.find_one({"cpf_cnpj": cpf_cnpj})

            if not cliente:
                print("\n@@@ Cliente não encontrado! @@@")
                continue

            sacar(cliente)

        elif opcao == "e":
            cpf_cnpj = input("Informe o CPF (PF) ou CNPJ (PJ) do cliente: ")

            cliente = clientes_collection.find_one({"cpf_cnpj": cpf_cnpj})

            if not cliente:
                print("\n@@@ Cliente não encontrado! @@@")
                continue

            extrato(cliente)

        elif opcao == "q":
            break

        elif opcao == "q":
            break


if __name__ == "__main__":
    main()
