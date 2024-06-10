extends Node2D

# Variável para armazenar a resposta correta
var resposta_correta = ""

# Estrutura de dados para armazenar perguntas, respostas e a resposta correta
var perguntas = [
	{
		"pergunta": "Qual das seguintes características é comum aos vírus?",
		"respostas": ["A) Eles possuem uma estrutura celular complexa.", "B) Eles podem se reproduzir de forma independente.", "C) Eles necessitam de uma célula hospedeira para se replicar.", "D)  Eles possuem ribossomos para sintetizar proteínas."],
		"resposta_correta": "c) Eles necessitam de uma célula hospedeira para se replicar.
",			
	},
	
	{
		"pergunta": "Qual é a principal diferença entre bactérias e vírus?",
		"respostas": ["A) Bactérias possuem núcleo definido, enquanto os vírus não possuem.", "B)Bactérias são sempre patogênicas, enquanto os vírus não são.", "C)  Bactérias podem se reproduzir sozinhas, enquanto os vírus necessitam de uma célula hospedeira.", "D) Bactérias são menores que os vírus."],
		"resposta_correta": "C)  Bactérias podem se reproduzir sozinhas, enquanto os vírus necessitam de uma célula hospedeira."
	},
	{
		"pergunta": "Qual das alternativas a seguir é uma doença causada por vírus?",
		"respostas": ["A) Tuberculose", "B) Sífilis", "C) Gripe", "D) Cólera"],
		"resposta_correta": "B) Gripe"
	},
	{
		"pergunta": "Os antibióticos são eficazes contra:",
		"respostas": ["A) Vírus", "B) Bactérias", "C)  Ambos, vírus e bactérias", "D) Fungos"],
		"resposta_correta": "D) Bactérias"
	},
	{
		"pergunta": "Qual das seguintes estruturas não é encontrada em bactérias?",
		"respostas": ["A) Membrana plasmática", "B) Ribossomos", "C) Mitocôndrias", "D)  Parede celular"],
		"resposta_correta": "C) Mitocôndrias"
	},
	{
		"pergunta": "Qual das seguintes doenças é causada por uma bactéria?",
		"respostas": ["A) Dengue", "B) RAIDS", "C) Tétano", "D) Hepatite B"],
		"resposta_correta": "C) Tétano"
	},
	{
		"pergunta": "Qual das seguintes características é verdadeira para os vírus?",
		"respostas": ["A) Eles podem crescer em meios de cultura sem células vivas.", "B)  Eles são visíveis ao microscópio óptico comum.", "C) Eles possuem material genético que pode ser DNA ou RNA, mas não ambos.", "D) Eles sempre possuem uma membrana lipídica."],
		"resposta_correta": "C)Eles possuem material genético que pode ser DNA ou RNA, mas não ambos.
"
	},
	{
		"pergunta": "Qual dos seguintes é um exemplo de bactéria Gram-positiva?",
		"respostas": ["A) Escherichia coli", "B) Staphylococcus aureus", "C) Salmonella typhi", "D) Neisseria meningitidis"],
		"resposta_correta": "B) Staphylococcus aureus"
	},
	{
		"pergunta": "Qual é o papel do plasmídeo nas bactérias??",
		"respostas": ["A) Realizar a fotossíntese.", "B) Conter genes que podem conferir resistência a antibióticos.", "C) Ser a principal estrutura de movimentação da célula.", "D) Armazenar nutrientes para períodos de escassez."],
		"resposta_correta": "B) Conter genes que podem conferir resistência a antibióticos."
	},


	# Adicione mais perguntas aqui...
]

# Índice da pergunta atual
var pergunta_atual = -1

# Chamado quando o nó entra na árvore da cena pela primeira vez.
func _ready():
	mostrarProximaPergunta()

func mostrarProximaPergunta():
	# Avança para a próxima pergunta
	pergunta_atual += 1

	if pergunta_atual < perguntas.size():
		var pergunta = perguntas[pergunta_atual]
		resposta_correta = pergunta["resposta_correta"]

		$RichTextLabel.bbcode_text = pergunta["pergunta"]
		$RES_1.text = pergunta["respostas"][0]
		$RES_2.text = pergunta["respostas"][1]
		$RES_3.text = pergunta["respostas"][2]
		$RES_4.text = pergunta["respostas"][3]
		$acertou_errou.text = ""

		# Conecte o evento "pressed" de cada botão ao método "_on_Button_pressed"
		$RES_1.connect("pressed", self, "_on_Button_pressed", [$RES_1.text])
		$RES_2.connect("pressed", self, "_on_Button_pressed", [$RES_2.text])
		$RES_3.connect("pressed", self, "_on_Button_pressed", [$RES_3.text])
		$RES_4.connect("pressed", self, "_on_Button_pressed", [$RES_4.text])
	else:
		# Todas as perguntas foram respondidas
		$RichTextLabel.bbcode_text = "Todas as perguntas foram respondidas."
		$RES_1.text = ""
		$RES_2.text = ""
		$RES_3.text = ""
		$RES_4.text = ""
		

func _on_Button_pressed(answer):
	if answer == resposta_correta:
		
		
		$RES_1.disabled = true
		$RES_2.disabled = true
		$RES_3.disabled = true
		$RES_4.disabled = true
		
			
		# Resposta correta - Mostre a próxima pergunta
		$AudioStreamPlayer2D/certaresposta.play()
		
		yield(get_tree().create_timer(9.0), "timeout")
		$AudioStreamPlayer2D/certaresposta.stop()
		$RES_1.disabled = false
		$RES_2.disabled = false
		$RES_3.disabled = false
		$RES_4.disabled = false
		$RES_1.disconnect("pressed", self, "_on_Button_pressed")
		$RES_2.disconnect("pressed", self, "_on_Button_pressed")
		$RES_3.disconnect("pressed", self, "_on_Button_pressed")
		$RES_4.disconnect("pressed", self, "_on_Button_pressed")
		mostrarProximaPergunta()
		

##############

# Índice da pergunta atual
func _on_cartas_pressed():
	if pergunta_atual < perguntas.size():
		var pergunta = perguntas[pergunta_atual]
		var respostas_erradas = pergunta["resposta_errada"]
		
		# Embaralhe as respostas erradas
		#respostas_erradas.shuffle()
		
		# Número aleatório de respostas para bloquear
		var cartas_rand = randi() % 3 + 1
		
		# Bloqueie as respostas erradas com base no número aleatório
		for i in range(cartas_rand):
			if i < respostas_erradas.size():
				# Certifique-se de que a resposta não seja a correta
				if respostas_erradas[i] != pergunta["resposta_correta"]:
					bloquearRespostaErrada(respostas_erradas[i])
		

func bloquearRespostaErrada(resposta):
	if resposta == $RES_1.text:
		$RES_1.disabled = true
		$RES_1.disconnect("pressed", self, "_on_Button_pressed")
	elif resposta == $RES_2.text:
		$RES_2.disabled = true
		$RES_2.disconnect("pressed", self, "_on_Button_pressed")
	elif resposta == $RES_3.text:
		$RES_3.disabled = true
		$RES_3.disconnect("pressed", self, "_on_Button_pressed")
	elif resposta == $RES_4.text:
		$RES_4.disabled = true
		$RES_4.disconnect("pressed", self, "_on_Button_pressed")

	
	
	




