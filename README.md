### printfunny:
Nome: PrintFunny.sh
Ideia: Baseado no hack do filme whoami onde os caras disparam contra as impressoras da rede e imprimem toneladas de troll.

#### Descrição:
 Para utilizar esse script, nesse momento, provavelmente não vai funcionar porque to alterando o source e ta cagado. 
Basicamente ela scaneia a rede procurando servidores cups na porta 631  e então dispara jobs de impressão para esses serviços localizados na rede.


Você precisará informar a rede qual irá scannear da seguinte forma:
```
# chmod u+x printfunny.sh
# ./printfunny.sh 10.0.0.0/24

```

Depois que eu escrevi esse source eu encontrei outros links de ferramentas com o propósito para ownar impressoras de rede, segue abaixo:
 - https://github.com/RUB-NDS/PRET

#### Dependências:
 - Nmap
 - figlet
