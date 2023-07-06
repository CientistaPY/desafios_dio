# Potência Tech powered by iFood | Ciências de Dados com Python
# Gerenciamento de Pedidos de Comida Online
# Desafio 4 proposto pelo módulo "Exercite sua Lógica com Desafios de Código" da Digital Innovation One
# Autor: [Luis Pontes]
# Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
# GitHub: [https://github.com/CientistaPY]

def main():
    n = int(input())
 
    total = 0
 
    for i in range(1, n + 1):
        pedido = input().split(" ")
        nome = pedido[0]
        valor = float(pedido[1])
        total += valor
        
    cupom = input().strip()

    if cupom == "10%":
        total -= total * 0.10
    elif cupom == "20%":
        total -= total * 0.20

    print(f"Valor total: {total:.2f}") 
 
if __name__ == "__main__":
    main()