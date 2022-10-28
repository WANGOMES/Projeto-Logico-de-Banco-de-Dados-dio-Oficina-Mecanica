# Projeto Lógico de Banco de Dados Oficina Mecânica
Construindo o Projeto Lógico de Banco de Dados de um Sistema de Emissão de Ordens de Serviços para uma Oficina Mecânica.

## Narrativa:
- Sistema de controle e gerenciamento de execução de ordens de serviço em uma oficina mecânica
- Clientes levam veículos à oficina mecânica para serem consertados ou para passarem por revisões  periódicas
- Cada veículo é designado a uma equipe de mecânicos que identifica os serviços a serem executados e preenche uma OS com data de entrega.
- A partir da OS, calcula-se o valor de cada serviço, consultando-se uma tabela de referência de mão-de-obra
- O valor de cada peça também irá compor a OSO cliente autoriza a execução dos serviços
- A mesma equipe avalia e executa os serviços
- Os mecânicos possuem código, nome, endereço e especialidade
- Cada OS possui: n°, data de emissão, um valor, status e uma data para conclusão dos trabalhos.

## Solução:
### 6 Entidades:
- Peca;
- Servico;
- Cliente;
- Mecanico;
- Equipe;
- OS.
### 3 Relaciomentos:
- Pecas_em (Relacionamento N X N entre Peca e OS);
- Servico_em (N X N entre Servico e OS);
- Trabalha_em (N X N entre Mecanico e Equipe).
### 4 Triggers:
Os triggers 1 e 2 estão relacionados à tabela _**Servicos_em**_ atualizando a tabela _**OS**_ sempre que houver uma adição ou subtração de um serviço na OS. 

      -- Trigger 1 --
      DELIMITER $
      CREATE TRIGGER Preco_Os AFTER INSERT
      ON Servico_em
      FOR EACH ROW
      BEGIN
      UPDATE OS SET Preco = Preco + (SELECT PrecoServico FROM Servico WHERE NEW.Servico_id=idServico)
	      WHERE idOs=NEW.Os_id;
      END$
      DELIMITER ;

      -- Trigger 2 --
      DELIMITER $
      CREATE TRIGGER Delete_Preco_Os AFTER DELETE
      ON Servico_em
      FOR EACH ROW
      BEGIN
      UPDATE OS SET Preco = Preco - (SELECT PrecoServico FROM Servico WHERE OLD.Servico_id=idServico)
	      WHERE idOs=OLD.Os_id;
      END$
      DELIMITER ;

Os triggers 3 e 4 fazem a mesma função dos dois anteriores, mas são acionados sempre que inserimos ou excluímos uma peça na tabela _**Pecas_em**_.

      
      -- Trigger 3 --
      DELIMITER $
      CREATE TRIGGER Increment_Pecas_Os AFTER INSERT
      ON Pecas_em
      FOR EACH ROW
      BEGIN
      UPDATE OS SET Preco = Preco + (SELECT PrecoPeca FROM Peca WHERE NEW.Peca_id=idPeca)
	      WHERE idOs=NEW.Os_id;
      END$
      DELIMITER ;

      -- Trigger 4 --
      DELIMITER $
      CREATE TRIGGER Decrement_Pecas_Os AFTER DELETE
      ON Pecas_em
      FOR EACH ROW
      BEGIN
      UPDATE OS SET Preco = Preco - (SELECT PrecoPeca FROM Peca WHERE OLD.Peca_id=idPeca)
	      WHERE idOs=OLD.Os_id;
      END$
      DELIMITER ;
 
Os arquivos .sql de criação de tabelas e manipulação de dados estão anexos.
