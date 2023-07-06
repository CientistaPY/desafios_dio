# Potência Tech powered by iFood | Ciências de Dados com Python
# Ganhe uma Sobremesa Especial!
# Desafio 3 proposto pelo módulo "Exercite sua Lógica com Desafios de Código" da Digital Innovation One
# Autor: [Luis Pontes]
# Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
# GitHub: [https://github.com/CientistaPY]
#----Bonus 1: implementado a interpolação de Srings na linha 25

valorPedido = int(input())

congrat = ["Parabens, ", "Que pena, ", "none",]
venceu = ["você ganhou ", "você nao ganhou ", "none",]
premio = ["uma sobremesa gratis!", "nenhum brinde especial.", "none",]


if valorPedido >= 50:
    msg1 = congrat[0]
    msg2 = venceu[0]
    msg3 = premio[0]
else:
    msg1 = congrat[1]
    msg2 = venceu[1]
    msg3 = premio[1]
    
print(f"{msg1}{msg2}{msg3}")