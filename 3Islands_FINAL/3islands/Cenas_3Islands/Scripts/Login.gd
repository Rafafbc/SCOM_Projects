extends Control

@onready var username_input: LineEdit = $VBoxContainer/UsernameInput
@onready var password_input: LineEdit = $VBoxContainer/PasswordInput
@onready var login_button: Button = $VBoxContainer/LoginButton
@onready var register_button: Button = $VBoxContainer/RegisterButton
@onready var error_label: Label = $VBoxContainer/ErrorLabel


var api_url: String = "http://localhost:3000"

func _ready():
	print(self)  # Certifique-se de que o nó está corretamente anexado
	print(get_tree())  # Deve retornar o SceneTree atual
	error_label.visible = false

	# Conecte os botões com Callables
	login_button.connect("pressed", Callable(self, "_on_login_button_pressed"))
	register_button.connect("pressed", Callable(self, "_on_register_button_pressed"))

func _on_login_button_pressed():
	if username_input.text == "" or password_input.text == "":
		error_label.text = "Preencha todos os campos."
		error_label.visible = true
		return

	# Adiciona requisição HTTP
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_on_login_response"))
	http_request.request(
		api_url + "/login",
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		JSON.stringify({"username": username_input.text, "password": password_input.text})
	)

func _on_login_response(result, response_code, _headers, body):
	var json = JSON.new()
	var parse_result = json.parse(body.get_string_from_utf8())

	if response_code == 200 and parse_result.error == OK:
		get_tree().change_scene("res://Cenas_3Islands/Pink_Man_fase1.tscn")
	else:
		error_label.text = parse_result.result.error if parse_result.result.has("error") else "Erro ao fazer login."
		error_label.visible = true

func _on_register_button_pressed():
	var next_scene_path = "res://Cenas_3Islands/Cadastro.tscn"
	var next_scene = ResourceLoader.load(next_scene_path)

	if next_scene and next_scene is PackedScene:
		get_tree().change_scene_to_packed(next_scene)
	else:
		print("Falha ao carregar a cena de cadastro. Verifique o caminho:", next_scene_path)
