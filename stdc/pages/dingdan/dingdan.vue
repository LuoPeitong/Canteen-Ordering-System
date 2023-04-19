<template>
	<view class="content">
		<view class="order" v-for="(item,i) in orderList" :key='i'>
			<view class="head">
				<text style="float: left;">{{item.location}}-{{item.floor}}</text><text style="float:right">{{item.orderTime}}</text>
			</view>
			<view v-for="(tco,j) in item.tcoList" :key='j'>
				<view>
					<!--只拿到菜品编号，需要拿到菜品名称-->
					{{tco.cuisineName}}<text style="float: right;">x{{tco.quantity}}</text>
				</view>
			</view>
			<view class="foot">
				<view class="load-button" @click="commentButton(item.orderId)">
					<text>评价</text>
				</view>
				<text style="float: right;">实付{{item.orderPrice}}元</text>
			</view>

		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				orderList: []
			}
		},
		mounted() {
			var user = uni.getStorageSync('user');
			//console.log(JSON.stringify(user))
			uni.request({
				url: "http://localhost:80/api/getPersonalOrder",
				method: 'post',
				data: {
					userId: user.userId
				},
				header: {
					'content-type': 'application/json'
				},
				success: res => {
					if (res.data.code == 200) {
						this.orderList = res.data.object;
					}
				}
			})
		},
		methods: {
			commentButton(value) {
				uni.navigateTo({
					url: '/pages/comment/addComment/addComment?orderId=' + value
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

	.order {
		width: 80%;
		height: 26%;
		background-color: #E3EDCD;
		margin-top: 15px;
		padding: 0 20px;
		border-radius: 15px;
	}

	.head {
		border-bottom: 2px solid black;
		height: 30px;
	}

	.foot {
		border-top: 2px solid black;
		height: 30px;
		margin-top: 15px;
	}

	.load-button {
		width: 18%;
		height: 80%;
		box-sizing: border-box;
		float: left;
		margin-top: 2%;
		margin-left: 1%;
		border: 1px solid black;
		display: flex;
		justify-content: center;
		align-items: center;
	}
</style>
