// 1. Alteração do tema da página
// Selecionando o botão e os elementos que terão seu tema alterado de claro para escuro, e vice-versa
var themeButthon = document.getElementById('themeButton');
// [...]

// Adicionando o _listener_ de evento ao botão
themeButthon.addEventListener('click', function() {
    var root = document.documentElement;    // Selecionando a raiz 'root' do documento

    // Checando o tema atual
    if (root.style.getPropertyValue('--color-lightSide-text')) {
        // Trocar para o tema escuro
        root.style.setProperty('--color-lightSide-text', 'var(--color-darkSide-text)');
        // [...]
        
    } else {
        // Trocar para o tema claro
        root.style.setProperty('--color-lightSide-text', 'var(--color-darkSide-text)');
        // [...]
    }
});