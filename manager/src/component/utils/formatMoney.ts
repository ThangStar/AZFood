const formatMoney = (price: any) => {
    const formatPrice = new Intl.NumberFormat('en-US').format(price)
    return formatPrice;
}
export default formatMoney;