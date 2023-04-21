<template>
	<view class="container">
		<scroll-view class="top" scroll-y="true">
			<view v-if="carts.length<1"><text>购物车中还没有商品哦~</text></view>
			<uni-section v-else="inputWrapper" type="line">
				<uni-data-select placeholder="请选择地址" class="selectInput" v-model="value" :localdata="range"
					@change="change"></uni-data-select>
			</uni-section>
			<view class="dishes" v-for="(item,i) in carts" :key='i'>
				<checkbox-group @change="checkClick(item)" class="selectBox">
					<checkbox :checked="item.check" />
				</checkbox-group>
				<view class="picBox" :style="{background: 'url('+item.picUrl+')'}"></view>
				<view class="thirdBox">
					<view class="cuisineBox">{{item.name}}</view>
					<view class="numberBox">
						<uni-section type="line" padding>
							<uni-number-box v-model="item.quantity" @change="quantityChange($event,i)" />
						</uni-section>
					</view>
				</view>
				<view class="fourthBox">
					<view class="priceBox">单价:¥{{item.price}}</view>
				</view>
			</view>
		</scroll-view>
		<view class="foot">
			<view class="foot-left">
				<checkbox-group @tap="checkAll" style="float:left;">
					<checkbox :checked="allChecked" />
				</checkbox-group>
				<text>全选</text>
			</view>
			<view class="foot-right">
				<text>总价:¥{{total}}</text>
				<button type="primary" plain="true" @click="gotoSettlement"
					style="height:100%;width:50%; float:right">结算</button>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				carts: [],
				allChecked: false,
				total: '0',
				canteenId: '',
				address: '',
				range: [],
				user: {}
			}
		},
		onShow() {
			this.carts = uni.getStorageSync('carts');
			//console.log(JSON.stringify(this.carts))
			this.getTotal()
		},
		onLoad(option) {
			this.canteenId = uni.getStorageSync('canteenId')
		},
		created() {
			this.user = uni.getStorageSync('user')
			this.getAddress()
		},
		methods: {
			getAddress() {
				uni.request({
					url: this.$baseUrl + "api/getAddress",
					method: 'post',
					data: {
						userId: this.user.userId
					},
					header: {
						'content-type': 'application/json'
					},
					success: res => {
						if (res.data.code == 200) {

							let newJsonParam = JSON.parse(JSON.stringify(res.data.object).replace(/addressId/g,
								"value"));
							newJsonParam = JSON.parse(JSON.stringify(newJsonParam).replace(/message/g,
							"text"));
							this.range = newJsonParam
							console.log(JSON.stringify(newJsonParam))
						}
					}
				})
			},
			change(e) {
				console.log(e)
				this.address = e
				console.log(this.address)
			},
			// 单个商品的选择
			checkClick(item) {
				item.check = !item.check
				if (!item.check) {
					this.allChecked = false
				} else {
					// 判断每一个商品是否是被选择的状态
					const goods = this.carts.every(item => {
						return item.check === true
					})
					if (goods) {
						this.allChecked = true
					} else {
						this.allChecked = false
					}
				}
				this.getTotal()
			},
			checkAll() {
				this.allChecked = !this.allChecked
				if (this.allChecked) {
					this.carts.map(item => {
						item.check = true
					})
					this.getTotal()
				} else {
					this.carts.map(item => {
						item.check = false
					})
					this.total = 0
				}
			},
			getTotal() {
				this.total = 0
				var len = this.carts.length
				for (var i = 0; i < len; i++) {
					if (this.carts[i].check) {
						this.total = this.total + this.carts[i].price * this.carts[i].quantity;
					}
				}
			},
			quantityChange(e, i) {
				this.carts[i].quantity = e
				this.getTotal()
			},
			gotoSettlement() {
				if (this.address == '') {
					setTimeout(() => {
						this.dialogToggle("请选择地址");
						setTimeout(() => {
							uni.hideToast();
						}, 1000)
					}, 0);
					return;
				}
				var user = uni.getStorageSync('user');
				uni.request({
					url: this.$baseUrl + "api/Settlement",
					method: 'post',
					data: {
						carts: this.carts,
						canteenId: this.canteenId,
						userId: user.userId,
						addressId: this.address
					},
					header: {
						'content-type': 'application/json'
					},
					success: res => {
						if (res.data.code == 200) {

							user.balance = res.data.object.balance;
							//console.log(JSON.stringify(user));
							uni.setStorageSync('user', user);
							setTimeout(() => {
								this.dialogToggle(res.data.message);
								setTimeout(() => {
									uni.hideToast();
								}, 1000)
							}, 0);

						} else if (res.data.code == 205) {
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
	.container {
		/*能够扩展和收缩 flex 容器内的元素，以最大限度地填充可用空间。*/
		display: flex;
		/*主轴为垂直方向，起点在上沿。（从上往下）*/
		flex-direction: column;
		/*将弹性 <div> 元素的所有项目的居中对齐：*/
		align-items: center;
		/*在容器中央对齐弹性项目：*/
		justify-content: center;
		background-color: #F0F0F0;
	}

	.top {
		width: 100%;
		height: 520px;
	}

	.foot {
		width: 100%;
		height: 50px;

		background-color: #F9F9F9;
	}

	.dishes {
		width: 85%;
		height: 80px;
		margin-top: 15px;
		margin-left: 20px;
		border-radius: 10px;
		background-color: #F9F9F9;
	}

	.selectBox {
		width: 20px;
		height: 20px;
		float: left;
		margin-top: 25px;
		margin-left: 10px;
	}

	.picBox {
		width: 60px;
		height: 60px;
		margin-left: 5px;
		margin-top: 5px;
		float: left;
	}

	.thirdBox {
		width: 100px;
		height: 70px;
		margin-left: 15px;
		margin-top: 1px;
		float: left;
	}

	.fourthBox {
		width: 70px;
		height: 70px;
		margin-left: 10px;
		margin-top: 1px;
		float: left;
	}

	.cuisineBox {
		width: 100%;
		height: 30px;
		margin-top: 3px;
	}

	.numberBox {
		width: 100%;
		height: 30px;
		margin-top: 5px;
	}

	.priceBox {
		width: 100%;
		height: 30px;

		margin-top: 5px;
	}

	.foot-left {
		width: 50%;
		float: left;
	}

	.foot-right {
		width: 50%;
		float: left;
	}

	.inputWrapper {
		width: 60%;
		height: 80upx;
		box-sizing: border-box;
		margin-top: 25px;
	}

	.selectInput {
		margin-top: 10px;
		margin-left: 50px;
		width: 70%;
		background-color: white;
	}
</style>