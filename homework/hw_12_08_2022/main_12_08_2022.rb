require_relative 'html_builder'

html_builder = HtmlBuilder.new do |html|
  html.body do |body|
    body.h1('Hello!', class_name: 'h1-formatted margin-10')

    body.p('This is paragraph') do |p|
      p.p('Paragraph inside paragraph') do |wq|
        wq.wwp do |wtf|
          wtf.opg("hs", class_name: "lol") do |ekl|
            ekl.mn
          end
        end
      end
    end

    body.div('New div element') do |div|
      div.p('Paragraph in div')
    end

    body.div(class_name: 'empty-div')
  end
end
puts html_builder.html_doc!
# <html>
# 	<body>
#   	<h1 class="h1-formatted margin-10">Hello!</h1>
#     <p>This is paragraph<p>Paragraph inside paragraph</p></p>
#     <div>New div element<p>Paragraph in div</p></div>
#     <div class="empty-div"/>
#   </body>
# </html>

print HtmlBuilder.new.html_doc!.class, "#{HtmlBuilder.new.html_doc!}!" #=> ''
