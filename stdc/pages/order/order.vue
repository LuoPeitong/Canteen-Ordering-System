<template>
	<view class="content">
		<view class="head">
			<view class="head-top">
				<view class="top-left">
					<image src='/static/logo.png' model="aspectFit" />
				</view>
				<view class="top-right">
					<text>{{canteen}}-{{floor}}</text>
				</view>
			</view>
			<view class="head-bottom">
				<uni-section type="line">
					<uni-search-bar @confirm="search" :focus="true" v-model="searchValue" @blur="blur" @focus="focus"
						@input="input" @cancel="cancel" @clear="clear">
					</uni-search-bar>
				</uni-section>
			</view>
		</view>
		<text>——————————————————————————————————————————————————</text>
		<!--scroll-into-view滚动到锚点-->
		<view class="main">
			<view class="main-left">
				<scroll-view :style="{ height: scrollHeight + 'px' }" scroll-y='true' class="left_box"
					:scroll-into-view="leftIntoView">
					<view class="left_item" v-for="(item,i) in rightArray" :key='i' @click="onLeft" :data-index="i"
						:id="'left-'+i" :class="{select:i == leftIndex}">
						{{item.classes}}
					</view>
				</scroll-view>
			</view>
			<view class="main-right">
				<view class="main-right-top">
					<!--@scroll监听滚动事件-->
					<scroll-view style="height:100%" @scroll="mainScroll" :scroll-into-view="scrollInto" scroll-y='true'
						class="right_box" scroll-with-animation="true">
						<slot></slot>
						<view class="right_item" v-for="(item,i) in rightArray" :key='i' :id="'item-'+i">
							<view class="rigth_title">
								{{item.classes}}
							</view>
							<view class="s_main" v-for="(items,j) in item.list" :key='j'>
								<view class="s_main_left" :style="{background: 'url('+items.picUrl+')'}"></view>
								<view class="s_main_right">
									<view class="name">{{items.name}}</view>
									<view class="price">¥{{items.price}}</view>
									<view class="quantity">
										<uni-section type="line" padding>
											<uni-number-box v-model="items.quantity" @change="changeValue(items)" />
										</uni-section>
									</view>
								</view>
							</view>
						</view>
						<!--<view class="fill-last" :style="{ height: fillHeight + 'px' }"></view>-->
					</scroll-view>
				</view>
				<view class="main-right-bottom">
					<view class="main-right-bottom-left">
						<button type="default" plain="true" @click="goto" style="height:100%;width:100%;">购物车</button>
					</view>
					<!--<view class="main-right-bottom-right">
						<button type="primary" plain="true" style="height:100%;width:100%;" @click="gotoSettlement">立即付款</button>
					</view>-->
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				canteen: '',
				floor: '',
				canteenId: '',
				searchValue: '123123',

				//leftArray: ['一', '二', '三', '四'],
				//rightArray: [{title: "第一类商品",list: [{picUrl: '/static/logo.png',name: '菜名1',price: '6',quantity: 0}, {picUrl: '/static/logo.png',name: '菜名2',price: '7',quantity: 0}, {picUrl: '/static/logo.png',name: '菜名3',price: '5',quantity: 0}]}, {title: "第二类商品",list: [{picUrl: '/static/logo.png',name: '菜名4',price: '3',quantity: 0}, {picUrl: '/static/logo.png',name: '菜名5',price: '1.5',quantity: 0}, {picUrl: '/static/logo.png',name: '菜名6',price: '6',quantity: 0}]}, {title: "第三类商品",list: [{picUrl: '/static/logo.png',name: '菜名7',price: '5',quantity: 0}, {picUrl: '/static/logo.png',name: '菜名8',price: '6',quantity: 0}, {picUrl: '/static/logo.png',name: '菜名9',price: '5',quantity: 0}]}],
				rightArray: [],
				scrollHeight: 400,
				scrollInto: "",
				leftIndex: 0,
				topArr: [],
				carts: [],
				scrollTopSize: 0
				//fillHeight: 0, // 填充高度，用于最后一项低于滚动区域时使用
			}
		},
		computed: {
			/* 计算左侧滚动位置定位 */
			leftIntoView() {
				return `left-${this.leftIndex > 3 ? this.leftIndex - 3 : 0}`;
			}
		},
		onLoad(option) {
			this.canteen = option.canteen;
			this.floor = option.floor;
			this.canteenId = option.canteenId;
			this.cart = uni.getStorageSync('cart');
		},
		created(){
			this.getCuisine()
		},
		methods: {
			getCuisine(){
				uni.request({
					url: this.$baseUrl + "api/cuisineInit",
					method: 'post',
					data: {
						canteenId: this.canteenId
					},
					header: {
						'content-type': 'application/json'
					},
					success: res => {
						if (res.data.code == 200) {
							this.rightArray = res.data.object;
						}
					}
				})
			},
			goto() {
				this.carts = this.unique(this.carts, "name")
				uni.setStorageSync('canteenId', this.canteenId);
				uni.setStorageSync('carts', this.carts)
				uni.switchTab({
					url: '../gwc/gwc'
				})
			},
			gotoSettlement() {
				this.carts = this.unique(this.carts, "name")
				//console.log(JSON.stringify(this.carts))
				var user = uni.getStorageSync('user');
				//console.log(JSON.stringify(user))
				uni.request({
					url: this.$baseUrl + "api/Settlement",
					method: 'post',
					data: {
						carts: this.carts,
						canteenId: this.canteenId,
						userId: user.userId
					},
					header: {
						'content-type': 'application/json'
					},
					success: res => {
						if (res.data.code == 200) {

							user.balance = res.data.object.balance;
							uni.setStorageSync('user', this.user);
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
			},
			blur(res) {
				uni.showToast({
					title: 'blur事件，输入值为：' + res.value,
					icon: 'none'
				})
			},
			focus(e) {
				uni.showToast({
					title: 'focus事件，输出值为：' + e.value,
					icon: 'none'
				})
			},
			input(res) {
				console.log('----input:', res)
			},
			clear(res) {
				uni.showToast({
					title: 'clear事件，清除值为：' + res.value,
					icon: 'none'
				})
			},

			cancel(res) {
				uni.showToast({
					title: '点击取消，输入值为：' + res.value,
					icon: 'none'
				})
			},

			/* 初始化滚动区域 */
			initScrollView() {
				return new Promise((resolve, reject) => {
					let view = uni.createSelectorQuery().select('#scroll_box');
					view.boundingClientRect(res => {
						console.log(res);
						this.scrollTopSize = res.top;
						this.scrollHeight = res.height;
						this.$nextTick(() => {
							resolve();
						});
					}).exec();
				});
			},

			// 点击左侧导航
			onLeft(e) {
				const index = e.currentTarget.dataset.index;
				console.log("onLeft", this.leftIndex)
				this.leftIndex = index
				this.scrollInto = `item-${index}`
				console.log("onLeft", this.scrollInto)
			},
			// 右侧滑动
			mainScroll(e) {
				let top = e.detail.scrollTop;
				let index = 0;
				/* 查找当前滚动距离 */
				for (let i = this.topArr.length - 1; i >= 0; i--) {
					/* 在部分安卓设备上，因手机逻辑分辨率与rpx单位计算不是整数，滚动距离与有误差，增加2px来完善该问题 */
					if (top + 2 >= this.topArr[i]) {
						index = i;
						break;
					}
				}
				this.leftIndex = index < 0 ? 0 : index;
			},
			changeValue(order) {
				this.carts.push(order)
			},
			//去重
			unique(arr, val) {
				const res = new Map()
				return arr.filter((item) => !res.has(item[val]) && res.set(item[val], 1))
			},
		}
	}
</script>

<style>
	.content {
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

	.scroll_box {
		display: flex;
		height: 100%;
	}

	.left_box {
		width: 100%;
	}

	.left_item {
		height: 80rpx;
	}

	/*.select {
		background-color: #4CD964;
	}*/

	.head {
		width: 100%;
		height: 150px;
		background: #F0F0F0;
	}

	.head-top {
		width: 100%;
		height: 90px;
	}

	.head-bottom {
		width: 100%;
		height: 40px;
	}

	.top-left {
		width: 60px;
		height: 60px;
		margin-top: 10px;
		margin-left: 5px;
		float: left;
	}

	.top-right {
		width: 200px;
		height: 40px;
		float: right;
		margin-right: 60px;
		margin-top: 20px;
	}

	.main {
		width: 100%;
		height: 430px;
	}

	.main-left {
		height: 100%;
		width: 28%;
		float: left;
		background-color: #CCFFFF;
	}

	.main-right {
		width: 68%;
		height: 100%;
		float: right;
	}

	.main-right-top {
		width: 100%;
		height: 85%;
	}

	.main-right-bottom {
		width: 100%;
		height: 13%;
		margin-top: 4px;
	}

	.main-right-bottom-right {
		width: 50%;
		height: 100%;
		float: left;
	}

	.main-right-bottom-left {
		width: 50%;
		height: 100%;
		/*float: left;*/
		float: right;
	}

	.s_main {
		width: 90%;
		height: 70px;
		margin-left: 7px;
		margin-bottom: 10px;
		background-color: #CCFFFF;
		border-radius: 10px;
	}

	.s_main_left {
		width: 28%;
		height: 80%;
		margin-left: 5px;
		margin-top: 5px;
		float: left;
	}

	.s_main_right {
		width: 62%;
		height: 80%;
		float: right;
		margin-top: 5px;
		border-radius: 10px;

	}

	.name {
		width: 90px;
		height: 25px;
	}

	.price {
		width: 50px;
		height: 25px;
		float: left;
	}

	.quantity {
		width: 80px;
		height: 25px;
		float: left;
	}

	image {
		margin-left: 15px;
		width: 70px;
		height: 70px;
	}
</style>