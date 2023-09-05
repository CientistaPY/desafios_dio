# Formação Python Developer
# Descomplicando a Criação de Pacotes de Processamento de Imagens em Python
# Desafio  proposto pelo módulo "Tratamento de Dados com Python" da Digital Innovation One
# Autor: [Luis Pontes]
# Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
# GitHub: [https://github.com/CientistaPY]

import setuptools
from setuptools import setup, find_packages

with open("README.md", "r") as f:
    page_description = f.read()

setup(
    name="ler_arquivos",
    version="0.0.1",
    author="Luis Pontes",
    author_email="mailtoluiscarlos@gmail.com",
    description="Pacote para ler arquivos Excel a partir de URLs",
    long_description=page_description,
    long_description_content_type="text/markdown",
    url="https://github.com/CientistaPY/desafios_dio/tree/main/Forma%C3%A7%C3%A3o%20Python%20Developer/TratamentodeDadoscomPython2",
    packages=find_packages(),
     install_requires=["pandas"],
    python_requires='>=3.8',
)