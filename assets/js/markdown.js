"user strict";

const Prism = require("./prism");

$(function() {
    const $preview = $(".preview");

    const renderer = new marked.Renderer();

    renderer.link = (href, title, text) => {
        return `<a href="${href}" target="_blank">${text}</a>`
    }

    marked.setOptions({
        renderer: renderer,
        breaks: true,
        langPrefix: "langage-",
        sanitize: true,
        highlight: (code, lang) => {
            if(lang && lang.match(":")) {
                lang = lang.sustring(0, lang.indexOf(":"));
            }

            if (lang in Prism.languages) {
                return Prism.highlight(code, Prism.languages[lang])
            }
            return code;
        },
    });

    $(".textarea").on("input", (e) => {

        const text = e.target.value;

        const html = marked(text);

        $preview.empty().append(html);
    })

    const defaultText = `Markdown preview`

    $("textarea").text(defaultText).trigger("input");

})