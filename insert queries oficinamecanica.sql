-- INSERTS --

INSERT INTO Mecanico VALUES (1, "Carlos Romulo de Alcantara", "Alameda das Flores, 121, Jardins, Jaboticatubas/MG", "Lanternagem"), (2, "Manoel Bandeira dos Santos", "Rua Tenente Brito Melo, SN, Barro Preto, Belo Horizonte/MG", "Eletrica"), (3, "Osvald de Andrade", "Rua das Princesas, 1212, Castelo, Belo Horizonte/MG", "Pintura"), (4, "Graciliano Ramos", "Rua H, 13, Alipio de Melo, Belo Horizonte/MG", "Hidraulica");

INSERT INTO Trabalha_em VALUES (1, 1), (1, 2), (2, 3), (2, 1), (1, 3);

INSERT INTO Equipe VALUES (1, "Reboque"), (2, "Urgência"),(3, "Manutenções Cotidianas");

INSERT INTO Peca VALUES (1, "Amortecedor da suspensão", 255.99), (2, "Anel de pistão", 25.58), (3, "Bomba elétrica combustivel", 349.95), (4, "Bronzina", 12.89), (5, "Buzina ou equipamento similar", 17.99), (6, "Lâmpada para veículos automotivos", 8.99), (7, "Pino e anel de trava (retenção)", 5.98), (8, "Pistão de liga leve de alumínio", 122.98), (9, "Baterias", 178.98), (10, "Terminal de direção", 298.99), (11, "Barra de direção", 469.99), (12, "Barra de ligação", 225.29), (13, "Terminal axial", 122.98), (14, "Lonas e pastilhas", 47.25), (15, "Rodas automotivas", 298.99), (16, "Vidro de segurança laminado de para-brisas", 469.99), (17, "Vidro de segurança temperado", 799.99), (18, "Fluído de freio", 25.95), (19, "Catalisador", 49.59), (20, "Filtro de óleo", 12.89);

INSERT INTO Servico VALUES (1, "CONSERTO", 599.95), (2, "REVISÃO", 399.95);

INSERT INTO Cliente VALUES (1, "Paulo Roberto Araujo", "Alameda das Flores, 121, Jardins, Jaboticatubas/MG", "3277-5523", "HMG-0248"), (2, "Francisco dos Santos Silva", "Rua Tenente Brito Melo, SN, Barro Preto, Belo Horizonte/MG", "3277-5522", "LPT-4625"), (3, "Emanuel de Andrade", "Rua das Princesas, 1212, Castelo, Belo Horizonte/MG", "3255-2022", "JSQ-7436"), (4, "Renata Adrielle de Morais", "Rua H, 13, Alipio de Melo, Belo Horizonte/MG", "3458-3377", "JJK-1960");

INSERT INTO OS VALUES (1, "2022-10-26", "2022-11-02","Em Andamento", 1, 0.00);

INSERT INTO OS VALUES (2, "2022-10-22", "2022-11-10","Pendente", 0, 0.00);

INSERT INTO Pecas_em VALUES (1, 1), (12, 1), (15, 1), (10, 1), (5, 1), (9, 1), (7, 1), (12, 1), (4, 1), (2, 2), (2, 2), (16, 2), (16, 2), (16, 2);

INSERT INTO Servico_em VALUES (1, 1), (1, 2), (2, 2);





 
-- QUERIES --

SELECT e.DescEquipe AS Descricao_Equipe, COUNT(t.Mecanico_id) AS Quant_Mecanico FROM Equipe e JOIN Trabalha_em t ON e.idEquipe=t.Equipe_id WHERE e.DescEquipe="Urgência";

SELECT mc.Especialidade FROM Mao_Obra m JOIN Equipe e ON m.Equipe_id=e.idEquipe JOIN Trabalha_em t ON t.Equipe_id=e.idEquipe JOIN Mecanico
mc ON mc.idMecanico=t.Mecanico_id WHERE idMaoDeObra=1;

SELECT SUM(s.PrecoServico) FROM Servico s JOIN Servico_em se ON se.Servico_id=s.idServico JOIN OS ON OS.idOs=se.Os_id WHERE OS.idOs=2;