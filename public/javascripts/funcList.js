// new a repository
const FuncList1 = ()=>{
	var list1 =    '<li class="funcList1">' +
                        '<div class="icon1"></div>'+
                        '<span class="createRepo">新建一个仓库</span>'+
                    '</li>'
	$('.container ul').append(list1);
	$('.funcList1').click(function(e){
        e.preventDefault ()
		if(!$('body').hasClass('informed')){
			$.get('html/inform1.htm',function(data){
				$('footer').after(data) 
			})
			$('body').addClass('informed')
		}
	})
}
// manage branch
const FuncList2 = () =>{
	var list2 =    '<li class="funcList2">' +
                        '<div class="icon2"></div>'+
                        '<span class="createRepo">git分支管理</span>'+
		            '</li>'
	$('.container ul').append(list2);
	$('.funcList2').click(function(){
		// $.load()
	})
}
// clone from github
const FuncList3 = () => {
	var list3 =   '<li class="funcList3">' +
                        '<div class="icon3"></div>'+
                        '<span class="createRepo">克隆github仓库</span>'+
		            '</li>'
	$('.container ul').append(list3);
	$('.funcList3').click(function(){
		if(!$('body').hasClass('informed')){
			$.get('html/inform3.htm',function(data){
				$('footer').after(data)
			})
			$('body').addClass('informed')
		}
	})
}

// global config
const FuncList4 = () =>{
    var list4 =    '<li class="funcList4">' +
                        '<div class="icon4"></div>'+
                        '<span class="createRepo">git全局设置</span>'+
                    '</li>'
    $('.container ul').append(list4);

    $('.funcList4').click(function(){
        $('.information').empty()
        $('.information').load('html/gitConfig.htm')
    })
}

// push to remote repository
const FuncList5 = ()=>{
    var list5 =    '<li class="funcList5">' +
                        '<div class="icon5"></div>'+
                        '<span class="createRepo">推送到远程仓库</span>'+
                    '</li>'
    $('.container ul').append(list5);
    $('.funcList5').click(function(){
        if(!$('body').hasClass('informed')){
			$('body').addClass('informed')            
            $.get('html/inform2.htm',function(data){
                $('footer').after(data)
                $('.inform').addClass('commit_path')
                $('.inform section').text('添加远程仓库地址')
                $('.commit_path .submitCommit').click(function(){
                    var $val  = $('.commit_path #commit_msg').val()
                    if($val !== ''){
                        $.post('/operator/addRemote',{remoteGit: $val}, function (data){
                            console.log(data)
                            m_inform.show(data)
                            $('.inform').remove()
                            $('body').removeClass('informed')
                        })
                    }else{
                        m_inform.show('远程仓库地址不能为空')
                    }
                })

            })
            $('body').addClass('informed')
        }
    })
}

// git skill
const FuncList6 = ()=>{
    var list6 = '<li class="funcList6">' +
        '<div class="icon6"></div>'+
        '<span class="createRepo">git教程(使用前先浏览)</span>'+
        '</li>'
    $('.container ul').append(list6);
    $('.funcList6').click(function(){

    })
}

new class FuncList{
	constructor() {
		this.funcList1 = FuncList1()
		this.funcList2 = FuncList2()
		this.funcList3 = FuncList3()
		this.funcList4 = FuncList4()
		this.funcList5 = FuncList5()
		this.funcList6 = FuncList6()
	}
}
