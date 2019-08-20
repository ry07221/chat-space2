$(document).on('turbolinks:load', function() {
  function appendUser(user){
    var html = `<div class="chat-group-user clearfix">
                 <p class="chat-group-user__name">${user.name}</p>
                 <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.user_id}" data-user-name="${user.name}">Add</a>
               </div>`
   $('#user-search-result').append(html);
  }

  function appendErrMsgToHTML(user) {
    var html = 
      `<div class="chat-group-user clearfix">
        <p class="chat-group-user__name">${user}</p>
      </div>`
   $('#user-search-result').append(html);
  }
  
  $('#user-search-field').on('keyup', function(e){   //テキストフィールドがkeyupしたら、テキストフィールドの文字を取得して変数inputに代入する
    var input = $("#user-search-field").val();
    var userlist = []
      $(".chat-group-user").each(function(){  // 削除ボタンに格納されているinputタグのクラス→この要素のvalueにuserのidが格納されてる
        userlist.push($(this).data("user-id"))  //idをuserlistに格納する
      })
   
    $.ajax({
      url: "/users",
      type: "GET",
      data: { keyword: input},
      dataType: 'json'
    })
    .done(function(data){
      $("#user-search-result").empty();
      if (data.length !== 0) {
        data.forEach(function(data){      //forEach : 与えられた関数を配列に含まれる各要素に対して一度ずつ呼び出す
          appendUser(data);
        });
      }
      else {
        appendErrMsgToHTML("No users");
      }
    })
    .fail(function(){
      alert('error');
    })
  });
  

  
  function addUser(id, name) {
    var html =`<div class='chat-group-user clearfix js-chat-member' data-user-id='${id}'>
                <input name='group[user_ids][]' type='hidden' value='${id}'>
                <p class='chat-group-user__name'>${name}</p>
                <div class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>Delete</div>
              </div>`
    $('#chat-group-users').append(html);
  }
  $("#user-search-result").on("click", ".chat-group-user__btn--add", function (){
    $('#chat-group-users').val();
      var id = $(this).data("user-id");
      var name =$(this).data("user-name");
      addUser(id, name);
      $(this).parent().remove();
    });
      $(document).on("click", ".user-search-remove", function(){
        $(this).parent().remove();
      });
  });
