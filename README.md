# Teste Promobit

**Pré-requisitos**

Sistema operacional: Ubuntu ou debian like

**Estas** f**erramentas devem estar instaladas na máquina local:**

- CLI-AWS com credenciais válidas configuradas em Admin-Access

    [https://docs.aws.amazon.com/pt_br/cli/latest/userguide/cli-chap-install.html](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/cli-chap-install.html)

- make instalado

    ```bash
    sudo apt install make
    ```

- Ansible

    [https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-18-04-quickstart-pt](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-18-04-quickstart-pt)

**Observação:** 

- Se julgar necessário, na linha 47 do arquivo **main.tf**, informe o IP da sua máquina por razões de segurança.
- Um arquivo executável do Terraform já está disponível na raiz do projeto
- Para fins de demonstração, as chaves pública e privada serão geradas na raiz do projeto, em ambiente de produção estas ficariam em local adequado

Na pasta raiz do projeto execute o comando **make**

```bash
make build
```

No término do  do processo um output de nome **op1** irá exibir o host criado pelo script

- A aplicação php poderá ser testada utilizando o {host}/php_app e {host}/php_app/ping
- A aplicação python poderá ser testada utilizando o {host}/python_app e {host}/python_app/ping

**INFORMAÇÕES SOBRE O PROJETO**

- O Terraform foi a ferramenta escolhida para configurar a infra-estrutura onde as aplicações estão instaladas.
- O Ansible foi a ferramenta escolhida para a instalação do ambiente no servidor deploy das aplicações.
- Após a criação da Infra Estrutura o Terraform faz uma chamada de comando para que o Ansible faça a gestão de configuração.
- O Terraform informa o host para o arquivo de configuração do Ansible possibilitando a gestão de configuração.
