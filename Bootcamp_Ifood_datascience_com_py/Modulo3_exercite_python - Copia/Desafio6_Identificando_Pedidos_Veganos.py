# Potência Tech powered by iFood | Ciências de Dados com Python
# Identificando Pedidos Veganos
# Desafio 5 proposto pelo módulo "Exercite sua Lógica com Desafios de Código" da Digital Innovation One
# Autor: [Luis Pontes]
# Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
# GitHub: [https://github.com/CientistaPY]
# OBS.: Na linha 14 tinha inconsistencia, " ehVegano = False " teve que ser modificada pra o funcionamento do Código

numPedidos = int(input())

for i in range(1, numPedidos + 1):
    prato = input()
    calorias = int(input())
    ehVegano = input()
    tipoPrato = "Vegano" if ehVegano == "s" else "Nao-vegano"
    print(f"Pedido {i}: {prato} ({tipoPrato}) - {calorias} calorias")
