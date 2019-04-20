class M_inform{
    show(content){
        if(!$('.informer').hasClass('showed')){
            $('.informer').addClass('showed').show()
            $('.informer').text(content.srv_msg || content.err_msg || content)
            setTimeout(function(){
                $('.informer').text('').hide()
                $('.informer').removeClass('showed')
            },2000)
        }
    }
}
// ajax for put
$.put = (url, data, callback)=>{
    $.ajax({
        url: url,
        method: 'put',
        data:  data,
        dataType: 'json',
        success(data){
            callback(data)
        },
        error(err){
            console.error(err)
        }
    })
}

const m_inform = Object.preventExtensions(new M_inform())

const  initConfig = setTimeout(()=>{
    $.get('/config/initconfig',function(res){ 
        m_inform.show(res)
    })
},200)

const clearSessionStorage = (()=>{
    document.body.onbeforeunload = ()=>{sessionStorage.clear()}
})()

const showHistoryList = (() =>{
    $('.information').load('html/historyLists.htm')
})()




