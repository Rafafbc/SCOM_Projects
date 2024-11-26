extends Control

@onready var username_input: LineEdit = $VBoxContainer/UsernameInput
@onready var password_input: LineEdit = $VBoxContainer/PasswordInput
@onready var confirm_password_input: LineEdit = $VBoxContainer/ConfirmPasswordInput
@onready var register_button: Button = $VBoxContainer/RegisterButton
@onready var back_button: Button = $VBoxContainer/BackToLoginButton
@onready var error_label: Label = $VBoxContainer/ErrorLabel


var api_url: String = "http://localhost:3000"

func _ready():
	# Conecta os sinais de forma correta usando Callable
	register_button.connect("pressed", Callable(self, "_on_register_button_pressed"))
	back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))
	error_label.visible = false

func _on_register_button_pressed():
	var username = username_input.text.strip_edges()
	var password = password_input.text.strip_edges()

	if username == "" or password == "":
		error_label.text = "Preencha todos os campos."
		error_label.visible = true
		return

	# Cria a requisição para registrar o usuário
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_on_register_response"))
	http_request.request(
		api_url + "/register",
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		JSON.stringify({"username": username, "password": password})  # Serializando o JSON
	)

func _on_register_response(result, response_code, _headers, body):
	# Imprime a resposta recebida (body) para depuração
	print("Resposta recebida: ", body.get_string_from_utf8())

	# Instancia JSON para fazer o parse
	var json = JSON.new()
	var parse_result = json.parse(body.get_string_from_utf8())

	# Declara parsed_data fora do bloco de verificação para que seja acessível em toda a função
	var parsed_data = null

	# Verifica se o parsing foi bem-sucedido
	if parse_result.error == OK:
		parsed_data = parse_result.result  # O resultado do JSON parse
	else:
		# Caso o parsing falhe, exibe o erro
		print("Erro ao parsear o JSON: ", parse_result.error)
		error_label.text = "Erro ao processar a resposta do servidor."
		error_label.visible = true
		return

	# Verifica o código de resposta HTTP
	if response_code == 201:
		# Cadastro realizado com sucesso, redireciona para a tela de login
		var next_scene_path = "res://Cenas_3Islands/Login.tscn"
		var next_scene = ResourceLoader.load(next_scene_path)

		if next_scene and next_scene is PackedScene:
			get_tree().change_scene_to_packed(next_scene)
		else:
			print("Falha ao carregar a cena de login. Verifique o caminho:", next_scene_path)
	else:
		# Verifica se parsed_data é um dicionário e contém a chave "error"
		if typeof(parsed_data) == TYPE_DICTIONARY:
			if "error" in parsed_data:
				error_label.text = parsed_data["error"]
			else:
				# Caso o campo error não esteja presente, exibe uma mensagem padrão
				error_label.text = "Erro ao registrar usuário. Tente novamente mais tarde."
		else:
			# Caso parsed_data não seja um dicionário, exibe um erro genérico
			error_label.text = "Erro ao processar a resposta. Verifique os dados enviados."
		
		error_label.visible = true


func _on_back_button_pressed():
	var next_scene_path = "res://Cenas_3Islands/Login.tscn"
	var next_scene = ResourceLoader.load(next_scene_path)

	if next_scene and next_scene is PackedScene:
		get_tree().change_scene_to_packed(next_scene)
	else:
		print("Falha ao carregar a cena de cadastro. Verifique o caminho:", next_scene_path)
