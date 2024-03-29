
// generate workstation dir
var dir = function (val,path){
	var tmp = val.split(/\./gi)
	var img = 'jpg'||'jpeg'
	var zip = 'zip'||'gz'||'tz'||'rar'
	var tips = '单击添加双击进入'
	path = path.replace(/\/$/g,'') + '/' + val
	if(tmp.length == 1 && 'LICENSE' !== val){
		var prop = 'folder'
	}else{
		var ext = tmp[tmp.length-1] 
		if('js' == ext ){
			var prop = 'js'
		}else if(zip == ext){
			var prop = 'zip'
		}else if(img == ext){
			var prop = 'img'
		}else if('gif' == ext){
			var prop = 'gif'
		}else if('png' == ext){
			var prop = 'png'
		}else if('java'==ext){
			var prop = 'java'
		}else if('php' == ext){
			var prop = 'php'
		}else if(('html') == ext){
			var prop = 'html'
		}else if('css' == ext){
			var prop = 'css'
		}else if('txt' == ext){
			var prop = 'txt'
		}else{
			var prop = 'bin'
		}
	}

	return `<div class='dir' path=${path} title=${tips}>
				<div class=${prop}></div>
				<span>${val}</span>
			</div>`
}

// show current information
var info = (data)=>{ 
	let { files , srv_msg } = data
	if(/重新/.test(srv_msg)){
		var status = '初始化' || ''
	}else{
		var status = '良好' || ''
	}

	return `<ul>
				<span>.git状态: <span style='color:#03e79b'>${status}</span></span>
				<span>当前文件数目: ${files.length}</span>
			</ul>`
}

var commitForm = ()=>{
	$('.submitCommit').click(function(){

		var $val = $('#commit_msg').val()
		if('' !== $val){
			$.post('/operator/addCommit',{data: $val}, function(data){
				console.log(data)
				m_inform.show(data)
			})
		}else{
			m_inform.show('请填写备注');
		}
	})
}

/**
	* 
	* @param {Object} data get data from server
	* @param {String} base_path git base path 
	* 
	*/
var operator = (data,base_path='')=>{
	setTimeout(function(){
		$('.inall').prepend(`<span>工作目录: ${base_path.replace(/(.)+(?<=\/)/gi,'')}</span>`) 
		$('.repo').empty()
		data.files.forEach(function(file){
			$('.repo').append(dir(file,base_path))
		})

		$('.init_infor .current_info').empty().append(info(data))

		// select all 
		$('#selectAll').click(function(){
			if($(this)[0].checked){
				$('.dir').addClass('marked')
			}else{
				$('.dir').removeClass('marked')
			}
		})

		// enter dir
		$('.dir').dblclick(function(){
			var base_path = $(this)[0].getAttribute('path')
			var text = $(this).find('span').text()
			$(this).removeClass('marked')
			sessionStorage.removeItem(text) 
			if($(this).find('.folder').hasClass('folder')){
				$.put('/init/current', {historyPath: $(this)[0].getAttribute('path')}, function(data){
					if(1 === data.code){
						operator(data, base_path)
						$('.inform').remove()
						$('body').removeClass('informed')
					}
				}) 
			}
		})

		// add dir to temp

		$('.dir').click(function(){
			m_inform.show(`${$(this)[0].getAttribute('path')}添加完成`)
			var text = $(this).find('span').text()
			if($(this).hasClass('marked')){
				$(this).removeClass('marked')
				sessionStorage.removeItem(text) 
			}else{
				$(this).addClass('marked')
				sessionStorage.setItem(text,Math.random().toString(36).substr(2))
			}
		})
		// add to temp

		$('.addTemp').click(function(e){
			if($('#selectAll')[0].checked){
				$.post('/operator/addtemp',{'tempdirs': 'all'},function(data){
					m_inform.show(data)
				})
			}else{
				$.post('/operator/addtemp',{'tempdirs': Object.keys(sessionStorage)},function(data){
					m_inform.show(data)
				})
			}
		})
		// add to commit

		$('.addCommit').click(function(e){
			$.get('html/inform1.htm',function(data){
				$('footer').after(data)
				$('#getPath').attr('id', 'commit_msg').attr('name', 'commit_msg')
				$('.inform').addClass('addCommit')
				$('.addCommit section').text('提交备注')
				$('.submitInit').attr('class', 'submitCommit')
				commitForm()
			})
			$('body').addClass('informed')
		})
	},500)
}
