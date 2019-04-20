(()=>{
    let count = 0;
    $('.no-git').append('<span></span>')
    let timer = setInterval(()=>{
        count++;
        if(count === 5){
            window.location.href = 'https://git-scm.com';
            clearInterval(timer)
        }
        $('.no-git span').text(`${count}s 后将跳转git官方网站`)
    },1000)
})()