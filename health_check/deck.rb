require 'squib'
require 'yaml'

copywright = "CC~BY-SA~3.0~FR Ajiro.fr, version: v1"

def cutmark(top, left, right, bottom, size)
  line x1: left, y1: top, x2: left+size, y2: top, stroke_width: 1, cap: :round
  line x1: left, y1: top, x2: left, y2: top+size, stroke_width: 1, cap: :round

  line x1: right, y1: top, x2: right, y2: top+size, stroke_width: 1, cap: :round
  line x1: right, y1: top, x2: right-size, y2: top, stroke_width: 1, cap: :round

  line x1: left, y1: bottom, x2: left+size, y2: bottom, stroke_width: 1, cap: :round
  line x1: left, y1: bottom, x2: left, y2: bottom-size, stroke_width: 1, cap: :round

  line x1: right, y1: bottom, x2: right-size, y2: bottom, stroke_width: 1, cap: :round
  line x1: right, y1: bottom, x2: right, y2: bottom-size, stroke_width: 1, cap: :round
end

Dir["data/*.yml"].each do |data|
  lang = File.basename(data, '.yml')
  content = YAML.load_file(data)

  questions = content['questions']
  Squib::Deck.new(cards: questions.size, layout: ['layout/card.yml', 'layout/questions.yml']) do
    background color: 'white'

    rect layout: 'safe', fill_color: 'lightgray'
    rect layout: 'inside'

    text str: questions.map {|i| i['title'] }, layout: 'title'
    circle layout: 'art_section', fill_color: 'lightgray'
    svg file: questions.map {|i| i['icon'] }, layout: 'art'

    rect layout: 'ok_section', fill_color: 'ok_color'
    svg file: 'happy.svg', layout: 'ok_icon'
    text str: questions.map {|i| i['ok'] }, layout: 'ok_text'

    rect layout: 'ko_section', fill_color: 'ko_color'
    svg file: 'crying.svg', layout: 'ko_icon'
    text str: questions.map {|i| i['ko'] }, layout: 'ko_text'

    text str: copywright, layout: 'copyright'

    rect layout: 'cut'
    save format: :pdf, file: "questions-#{lang}.pdf", width: "29.7cm", height: "21cm", trim: 40, gap: 0
    save format: :pdf, file: "questions-#{lang}-print.pdf", width: "29.7cm", height: "21cm"
    showcase range: 0..4, offset: 0.8, trim: 40, trim_radius: 16, fill_color: '#3D7890'
    hand range: 0..10, trim: 40, trim_radius: 16, fill_color: '#3D7890'
  end

  answers = content['answers'] * 8
  Squib::Deck.new(cards: answers.size, layout: ['layout/card.yml', 'layout/anwsers.yml']) do
    background color: 'white'

    rect layout: 'safe', fill_color: answers.map {|i| i['border'] }
    rect layout: 'inside'

    svg file: answers.map {|i| i['icon'] }, layout: 'picture'
    text str: answers.map {|i| i['text'] }, layout: 'text'

    text str: copywright, layout: 'copyright'

    rect layout: 'cut'
    save format: :pdf, file: "answers-#{lang}.pdf", width: "29.7cm", height: "21cm", trim: 40, gap: 0
    save format: :pdf, file: "answers-#{lang}-print.pdf", width: "29.7cm", height: "21cm"
  end
end
