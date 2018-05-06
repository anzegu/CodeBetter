This is an app that offers users an onlince text editor and compiler using the ace-rails gem and Judge0 API.

<b>PROJECT CREATION</b>

The project is generated like a standart ROR APP.
Gems that were used are: 
```
gem 'bootstrap', '~> 4.0.0'
gem 'devise'
gem 'jquery-rails'
gem 'ace-rails-ap'
gem 'http'
```
The view files are located in the "home" folder. It's roues are:
```
  root 'home#index'
  get 'editor/:id/:lid' => 'home#editor', :as => :editor
  get 'challanges/' => 'problems#index_home', :as => :solve
  get 'languages/:id' => 'home#language', :as => :language
  get 'code_request/' => 'home#code_request', :as => :code_request
  get 'users/' => 'home#users', :as => :users
  get 'change/:id' => 'home#change', :as => :change
```

---------------------------------------------------------

<b>ACE EDITOR</b>

The ace-rails-ap gem allows the use of Ace Editor like you would use it in any other app. Just include the script and required styling as per the instructions on the official Ace Editor website. https://ace.c9.io/#nav=embedding
```
<div id="editor"></div>
    
<script src="/ace-builds/src-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>
<script>
    var editor = ace.edit("editor");
    editor.setTheme("ace/theme/monokai");
    editor.session.setMode("ace/mode/javascript");
</script>
```

---------------------------------------------------------

<b>Jude0 API</b>

This API runs code and returns the output to the sender. All you have to do is set up an HTTP request with ruby and that's where the HTTP gem comes in play.
```
@body = HTTP.headers(:accept => "application/json").post("https://api.judge0.com/submissions/?base64_encoded=false&wait=false", :form => {:source_code => @code, :language_id => @judgeid, :stdin => @input}).parse
    @token = @body["token"]
    @comp = HTTP.headers(:accept => "application/json").get("https://api.judge0.com/submissions/" + @token).parse
```
The output has to be parsed in order to show individual parts of the output. Judge0 requires a token to compile the code, so the first request is for the token. With it you make a second request and that's where the result is sent.
Judge0 compiles a variety of languages, to se a list of them visit the official page: https://api.judge0.com/#statuses-and-languages-languages
Everything else that you would need to know about Judge0: https://api.judge0.com/

<b>HEROKU</b>
