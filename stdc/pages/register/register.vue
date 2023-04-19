<template>
	<view class="zai-box">
		<image src="../../static/zaizai-login/register.png" mode='aspectFit' class="zai-logo"></image>
		<view class="zai-title">加入干饭人</view>
		<view class="zai-form">
			<input class="zai-input" placeholder-class placeholder="请输入用户名" @input="getUsername"/>
			<input class="zai-input" placeholder-class password placeholder="请输入密码" @input="getPassword"/>
			<input class="zai-input" placeholder-class password placeholder="请再输入一次密码" @input="getPassword2"/>
			<button class="zai-btn" @tap="register">立即注册</button>
			<navigator url="../login/login" open-type='navigateBack' hover-class="none" class="zai-label">已有账号，点此去登录.</navigator>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				username: '',
				password: '',
				password2: ''
			}
		},
		methods: {
			getUsername:function(event){
			    this.username = event.detail.value  
			},
			getPassword:function(event){
			    this.password = event.detail.value  
			},
			getPassword2:function(event){
			    this.password2 = event.detail.value  
			},
			register(){
				if(this.password == this.password2)
				{
					uni.request({
						url:this.$baseUrl + "api/register",
						method:'post',
						data:{
							username:this.username,
							password:this.password
						},
						header: {
							'content-type': 'application/json'
						},
						success:res=>{
							if(res.data.code == 200){
								setTimeout(() => {
								    this.dialogToggle(res.data.message);
								    setTimeout(() => {
								        uni.hideToast();
								        //关闭提示后跳转
								        uni.redirectTo({
								        	url: '../login/login'
								        });
								    }, 1000)
								}, 0);
							}
							else{
								setTimeout(() => {
								    this.dialogToggle(res.data.message);
								    setTimeout(() => {
								        uni.hideToast();
								    }, 1000)
								}, 0);
							}
						}
					})
				}
				else
				{
					this.dialogToggle('两次密码不一致')
				}
			},
			dialogToggle(type) {
				uni.showToast({
					title: type,
					icon: 'none',    //如果要纯文本，不要icon，将值设为'none'
					duration: 2000    //持续时间为 2秒
				})
			}
		}
	}
</script>

<style>
.zai-box{
		padding: 0 100upx;
		position: relative;
	}
	.zai-logo{
		width: 100%;
		width: 100%;
		height: 310upx;
	}
	.zai-title{
		position: absolute;
		top: 0;
		line-height: 360upx;
		font-size: 68upx;
		color: #fff;
		text-align: center;
		width: 100%;
		margin-left: -100upx;
	}
	.zai-form{
		margin-top: 300upx;
	}
	.zai-input{
		background: #e2f5fc;
		margin-top: 30upx;
		border-radius: 100upx;
		padding: 20upx 40upx;
		font-size: 36upx;
	}
	.input-placeholder, .zai-input{
		color: #94afce;
	}
	.zai-label{
		padding: 60upx 0;
		text-align: center;
		font-size: 30upx;
		color: #a7b6d0;
	}
	.zai-btn{
		background: #ff65a3;
		color: #fff;
		border: 0;
		border-radius: 100upx;
		font-size: 36upx;
		margin-top: 60upx;
	}
	.zai-btn:after{
		border: 0;
	}
	/*按钮点击效果*/
	.zai-btn.button-hover{
		transform: translate(1upx, 1upx);
	}
</style>
