$(document).on('turbolinks:load', function() {
  function appendProduct(user){
    var html = `<div class="chat-group-user clearfix">
                 <p class="chat-group-user__name">${user.name}</p>
                 <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.user_id}" data-user-name="${user.name}">Add</a>
               </div>`
   $('#user-search-result').append(html);
  }
  
  $('#user-search-field').on('keyup', function(e){   //テキストフィールドがkeyupしたら、テキストフィールドの文字を取得して変数inputに代入する
    var input = $("#user-search-field").val();
    if (input.length == 0)
    { 
      $("#user-search-result").empty();
      return;
    }

    //チャットメンバーにすでに登録されているユーザを取得
    var x = $('.js-user');
    var arr = [];
    x.each(function(i, ele) {
      arr.push(ele.value);
    })

    $.ajax({
      url: "/users",
      type: "GET",
      data: { keyword: input,
              user_id: arr},
      dataType: 'json'
    })
    .done(function(users){
      $("#user-search-result").empty();

      if (data.length !== 0) {
        data.forEach(function(data){
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

