# Formação Python Developer
# Sistema Bancário v3
# Desafio  proposto pelo módulo "Modelando o Sisema Bancãrio em POO com Python" da Digital Innovation One
# Autor: [Luis Pontes]
# Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
# GitHub: [https://github.com/CientistaPY]

Desafio realizdo conforme instruções, adicionadas seguintes implementações:


1- Adicionado o atributo 'senha' à class Conta:
----------------------trecho antigo:-------------------------

class Conta:
    def __init__(self, numero, cliente):
        self._saldo = 0
        self._numero = numero
        self._agencia = "0001"
        self._cliente = cliente
        self._historico = Historico()
        
------------------------trech novo:--------------------------

class Conta:
    def __init__(self, numero, cliente, senha=0000):
        self._saldo = 0
        self._numero = numero
        self._agencia = "0001"
        self._cliente = cliente
        self._historico = Historico()  # Objeto para registrar o histórico de transações da conta
        self._senha = senha
-------------------------------------------------------------

2- Adicionado função verificar_clientes, que confere o cpf bem como a senha:
------------------------trech novo:--------------------------

def verificar_cliente(clientes):
    cpf = input("Informe o CPF do cliente: ")
    cliente = filtrar_cliente(cpf, clientes)
    if not cliente:
        print("\n@@@ Cliente não encontrado! @@@")
        return None
    senha = input("Solicite que cliente digite a senha: ") 
    conta = recuperar_conta_cliente(cliente)
    if not conta:
        return None
    if senha != conta.senha:  # Verifica se a senha está incorreta
        print("\n@@@ Senha incorreta! Acesso não autorizado. @@@")
        return None
    return cliente

-------------------------------------------------------------
3- substituido o seguinte trechio de código pela chamada da função implementada 'verificar_clientes', nas funções 'sacar', 'depositar' e 'exibir_extrato':
----------------------trecho antigo:-------------------------

    cpf = input("Informe o CPF do cliente: ")
    cliente = filtrar_cliente(cpf, clientes)

    if not cliente:
        print("\n@@@ Cliente não encontrado! @@@")
        return

------------------------trech novo:--------------------------
    cliente = verificar_cliente(clientes)
    if not cliente:
        return
-------------------------------------------------------------