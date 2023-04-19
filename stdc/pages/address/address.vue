<template>
	<view class="content">
		<view class="load-button">
			<button class="button" type="primary" @tap="gotoEditAddress2">新增</button>
		</view>
		
		<view class="address" v-for="(item,i) in addressList" :key='i'>
			<view class="left">
				<view class="left_first">{{item.message}}</view>
				<view class="left_sec">{{item.consignee}} {{item.tel}}</view>
			</view>
			<view class="right">
				<button @tap="gotoEditAddress(item)">编辑</button>
			</view>
		</view>

	</view>
</template>

<script>
	export default {
		data() {
			return {
				addressList: [{
						addressId: 1,
						userId: 1,
						message: '图书馆三楼',
						consignee: '小张',
						tel: '13487490333'
					},
					{
						addressId: 1,
						userId: 1,
						message: '图书馆三楼',
						consignee: '小张',
						tel: '13487490333'
					}
				]
			}
		},
		mounted() {
			var user = uni.getStorageSync('user');
			uni.request({
				url: "http://localhost:80/api/getAddress",
				method: 'post',
				data: {
					userId: user.userId
				},
				header: {
					'content-type': 'application/json'
				},
				success: res => {
					if (res.data.code == 200) {
						this.addressList = res.data.object;
					}
				}
			})
		},
		methods: {
			gotoEditAddress(item) {
				var mynavData = JSON.stringify(item);
				uni.navigateTo({
					url: '/pages/address/editAddress/editAddress?address=' + mynavData
				});
			},
			gotoEditAddress2() {
				uni.navigateTo({
					url: '/pages/address/editAddress/editAddress'
				});
			}
			
		}
	}
</script>

<style>
	.content {

		display: flex;
		flex-direction: column;
		align-items: center;
		width: 100vw;
		height: 100vh;
		background-color: #F0F0F0;
	}

	.address {
		width: 90%;
		height: 15vh;
		background-color: #E3EDCD;
		margin-top: 15px;
	}

	.left {
		float: left;
		width: 80%;
		height: 100%;
	}

	.left_first {
		width: 100%;
		height: 50%;
		padding: 5px 20px 0 20px;
	}

	.left_sec {
		width: 100%;
		height: 50%;
		padding: 0 20px;
	}

	.right {
		justify-content: center;
		padding: 20px 3px;
	}

	.load-button {
		width: 90%;
		height: 80upx;
		box-sizing: border-box;
		padding: 0 20px;
	}

	.button {
		width: 100%;
		height: 80upx;
		border-radius: 20px;
		box-sizing: border-box;
		display: flex;
		justify-content: center;
		align-items: center;
		margin-top: 10px;
	}
</style>
