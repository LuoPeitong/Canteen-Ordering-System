<template>
	<view class="content">
		<view class="inputWrapper">
			<input class="input" type="text" placeholder="请输入用户名" v-model="username" />
		</view>
		<view class="inputWrapper">
			<input class="input" type="password" placeholder="请输入密码" v-model="password" />
		</view>
		<view class="inputWrapper">
			<input class="input" type="text" placeholder="请输入所在餐厅" v-model="location" />
		</view>
		<view class="inputWrapper">
			<input class="input" type="text" placeholder="请输入餐厅楼层" v-model="floor" />
		</view>
		<view class="load-button">
			<button class="button" type="primary" @tap="registerSubmit">注册</button>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				username: '',
				password: '',
				location: '',
				floor:''
			}
		},
		onLoad() {

		},
		methods: {
			registerSubmit() {
				if (this.username == '') {
					setTimeout(() => {
						this.dialogToggle("用户名为空");
						setTimeout(() => {
							uni.hideToast();
						}, 1000)
					}, 0);
					return;
				} else if (this.password == '') {
					setTimeout(() => {
						this.dialogToggle("密码为空");
						setTimeout(() => {
							uni.hideToast();
						}, 1000)
					}, 0);
					return;
				}
				uni.request({
					url: this.$baseUrl + "api/canteenRegister",
					method: 'post',
					data: {
						username: this.username,
						password: this.password,
						location: this.location,
						floor: this.floor
					},
					header: {
						'content-type': 'application/json'
					},
					success: res => {
						if (res.data.code == 200) {
							uni.setStorageSync('canteen', res.data.object);
							console.log(res.data.message)
							//弹窗-延迟-跳转
							setTimeout(() => {
								this.dialogToggle(res.data.message);
								setTimeout(() => {
									uni.hideToast();
									//关闭提示后跳转
									uni.navigateTo({
										url:'/pages/index/index'
									})
								}, 1000)
							}, 0);
						} else if (res.data.code == 400) {
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
		width: 100vw;
		height: 100vh;
		background-color: bisque;
	}

	.inputWrapper {
		width: 70%;
		height: 80upx;
		background: white;
		border-radius: 20px;
		box-sizing: border-box;
		padding: 0 20px;
		margin-top: 25px;
	}

	.inputWrapper .input {
		width: 100%;
		height: 100%;
		text-align: left;
		font-size: 15px;
	}

	.load-button {
		width: 70%;
		height: 80upx;
		box-sizing: border-box;
		padding: 0 20px;
		margin-top: 15px;
	}

	.button {
		width: 100%;
		height: 80upx;
		border-radius: 20px;
		box-sizing: border-box;
		display: flex;
		justify-content: center;
		align-items: center;
		margin-top: 25px;
	}
</style>
