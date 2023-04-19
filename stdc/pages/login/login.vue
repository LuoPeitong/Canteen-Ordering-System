<template>
	<view class="content">
		<view class="zai-box">
			<image src="../../static/zaizai-login/login.png" mode='aspectFit' class="zai-logo"></image>
			<view class="zai-title">干饭人</view>
			<view class="zai-form">
				<input class="zai-input" placeholder-class placeholder="请输入用户名" @input="getUsername" />
				<input class="zai-input" placeholder-class password placeholder="请输入密码" @input="getPassword" />
				<view class="zai-label"></view>
				<button class="zai-btn" @tap="login">立即登录</button>
				<navigator url="../register/register" hover-class="none" class="zai-label">还没有账号？点此注册.</navigator>
			</view>
		</view>
	</view>
	<!--html，显示内容-->
</template>

<script>
	export default {
		data() {
			return {
				username: '',
				password: '',
				user: {
					userId:'',
					username: '',
					name: '',
					balance: 0,
					studentNo: ''
				}
			}
		},
		methods: {
			getUsername: function(event) {
				this.username = event.detail.value
			},
			getPassword: function(event) {
				this.password = event.detail.value
			},
			login() {
				uni.request({
					url: this.$baseUrl + "api/login",
					method: 'post',
					data: {
						username: this.username,
						password: this.password
					},
					header: {
						'content-type': 'application/json'
					},
					success: res => {
						if (res.data.code == 200) {
							this.user.username = res.data.object.username;
							this.user.name = res.data.object.name;
							this.user.balance = res.data.object.balance;
							this.user.studentNo = res.data.object.studentNo;
							this.user.userId = res.data.object.userId;
							uni.setStorageSync('user', this.user);//缓存，相当于java session
							setTimeout(() => {
								this.dialogToggle(res.data.message);
								setTimeout(() => {
									uni.hideToast();
									//关闭提示后跳转
									uni.switchTab({
										url: '../index/index'
									});
								}, 1000)
							}, 0);
						} else {
							setTimeout(() => {
								this.dialogToggle(res.data.message);
								setTimeout(() => {
							  uni.hideToast();
								}, 1000)
							}, 0);
						}
					}
				})
			},
			dialogToggle(type) {
				uni.showToast({
					title: type,
					icon: 'none', //如果要纯文本，不要icon，将值设为'none'
					duration: 2000 //持续时间为 2秒
				})
			}
		}
	}
</script>

<style>
	.content {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
	}

	.zai-box {
		padding: 0 100upx;
		position: relative;
	}

	.zai-logo {
		width: 100%;
		width: 100%;
		height: 310upx;
	}

	.zai-title {
		position: absolute;
		top: 0;
		line-height: 360upx;
		font-size: 68upx;
		color: #fff;
		text-align: center;
		width: 100%;
		margin-left: -100upx;
	}

	.zai-form {
		margin-top: 300upx;
	}

	.zai-input {
		background: #e2f5fc;
		margin-top: 30upx;
		border-radius: 100upx;
		padding: 20upx 40upx;
		font-size: 36upx;
	}

	.input-placeholder,
	.zai-input {
		color: #94afce;
	}

	.zai-label {
		padding: 60upx 0;
		text-align: center;
		font-size: 30upx;
		color: #a7b6d0;
	}

	.zai-btn {
		background: #ff65a3;
		color: #fff;
		border: 0;
		border-radius: 100upx;
		font-size: 36upx;
	}

	.zai-btn:after {
		border: 0;
	}

	/*按钮点击效果*/
	.zai-btn.button-hover {
		transform: translate(1upx, 1upx);
	}
</style>
