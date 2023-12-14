'use client'
import '../table-details/page.css'
import { showAlert } from '@/component/utils/alert/alert';
import { formatDateTime } from '@/component/utils/formatDate';
import formatMoney from '@/component/utils/formatMoney';
import { getCategoryList, getCategoryListAsync, getItemtList, getMenuListAsync, getMenuItemListAsync, getMenuItemtList, getFilterCategoryListAsync, getSearchMenuListAsync, getPriceList, getPriceForSize } from '@/redux-store/menuItem-reducer/menuItemSlice';
import { createOrderAsync, incrementProductAsync, deleteOrderAsync, getOrder, getOrderInTableListAsync, getStatus, payBillAsync, updateOrderAsync, deleteAllOrderAsync, updatePriceOrderAsync } from '@/redux-store/order-reducer/orderSlice';
import { AppDispatch } from '@/redux-store/store';
import { useSearchParams } from 'next/navigation';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Modal, ModalHeader, ModalBody, ModalFooter, Button } from 'reactstrap';
import { useSocket } from "@/socket/io.init"
import { log } from 'console';
import { getDVTList, getDvtListAsync } from '@/redux-store/kho-reducer/nhapHangSlice';
import MonetizationOnIcon from '@mui/icons-material/MonetizationOn';

export default function TableDetails() {
    const searchParams = useSearchParams()
    const url = `${searchParams}`
    const tableID = url ? url.split('tableID=')[1] : null;
    const [modal1, setModal1] = useState(false);
    const [modal, setModal] = useState(false);
    const [modalDelAll, setmodalDelAll] = useState(false);
    const [modal2, setModal2] = useState(false);
    const [modal3, setModal3] = useState(false);
    const [isUpdate, setIsUpdate] = useState(false);

    const dispatch: AppDispatch = useDispatch();
    const orders: any = useSelector(getOrder);
    const menuItems: any = useSelector(getItemtList);
    const statusRD: any = useSelector(getStatus);
    const priceList: any = useSelector(getPriceList);
    const categoryList: any = useSelector(getCategoryList);
    const dvTinhList: any = useSelector(getDVTList);

    const [listPriceProd, setListPriceProd] = useState<any[]>([]);
    const [listPriceOfProd, setListPriceOfProd] = useState([]);
    const [listItem, setlistItem] = useState<any[]>([]);
    const [order, setOrder] = useState<any[]>([]);
    const [itemMenus, setItemMenus] = useState<any[]>([]);
    const [itemCategory, setItemCategory] = useState("");
    const [listCategory, setListCategory] = useState<string[]>([]);
    const [listDVTList, setListDVTList] = useState([]);
    const [searchName, setSearchName] = useState("")

    const [priceProduct, setPriceProduct] = useState<number>(0);
    const [currentProductId, setCurrentProductId] = useState(null);
    const [userID, setUserID] = useState();
    const [orderID, setOrderID] = useState();
    const [idItemDelete, setIdDelete] = useState();
    const [payMethod, setPayMethod] = useState<number>(1)

    useEffect(() => {
        const fetchData = async () => {
            await dispatch(getMenuListAsync());
            await dispatch(getDvtListAsync());
            await dispatch(getCategoryListAsync());
            await dispatch(getPriceForSize());
        }
        fetchData();
    }, [dispatch]);

    useEffect(() => {
        if (menuItems && menuItems.data) {
            setlistItem(menuItems.data);
        };
        if (priceList && priceList.data) {
            setListPriceProd(priceList.data);
        }
    }, [menuItems, priceList]);



    const toggle1 = () => setModal1(!modal1);
    const toggle = () => setModal(!modal);
    const toggleDelAll = () => setmodalDelAll(!modalDelAll);
    const openModal = (data: any = null) => {
        if (data != null) {
            setIdDelete(data);
        }
        toggle();
    }

    const openModalDel = () => { toggleDelAll(); }
    const toggle2 = () => setModal2(!modal2);
    const openModal2 = () => { toggle2(); }
    const toggle3 = () => setModal3(!modal3);
    const openModal3 = (item: any) => {
        if (item.price !== 0) {
            return;
        }
        setOrderID(item.orderID);
        setCurrentProductId(item.productID);
        const price: any = setPriceForProd(item.productID);
        setListPriceOfProd(price);
        toggle3();
    }
    const setPriceForProd = (prodId: number) => {
        const filteredProducts = listPriceProd.filter((item: any) => item.product_id == prodId);
        return filteredProducts;
    }

    useEffect(() => {
        const userJSON = localStorage.getItem("user");
        if (userJSON) {
            const user = JSON.parse(userJSON);
            const userID = user.userID;
            setUserID(userID);
        } else {
            console.log("Dữ liệu user không tồn tại trong localStorage");
        }
    }, [userID]);

    useEffect(() => {
        const fetchData = async () => {
            await dispatch(getOrderInTableListAsync(tableID));
            await dispatch(getMenuListAsync());
        }
        fetchData();
    }, []);

    useEffect(() => {

        if (orders && Array.isArray(orders.orders)) {
            setOrder(orders.orders);
        }
        if (menuItems && menuItems.data) {
            setItemMenus(menuItems.data);
        }
        if (categoryList && categoryList.resultRaw) {
            setListCategory(categoryList.resultRaw);
        }
        if (dvTinhList && dvTinhList.resultRaw) {
            setListDVTList(dvTinhList.resultRaw);
        }
    }, [orders, menuItems, categoryList, dvTinhList]);

    const caculatorTotal = () => {
        let totalAll = 0;
        order.forEach(item => {
            const price = item.price_produc ? item.price_produc : item.price
            totalAll += price * item.quantity
        });
        return totalAll;
    }


    const handlePlusOrder = async (item: any) => {


        var productID;
        var price;
        if (item.productID !== undefined) {
            productID = item.productID;
            price = item.price_produc
        } else {
            productID = item.id;
            price = item.price
        }

        const data = {
            userID: userID,
            tableID: tableID,
            productID: productID,
            quantity: 1,
            category: item.category,
            price: price ? price : item.price
        }

        if (isUpdate) {
            await dispatch(updateOrderAsync({ data, orderID }));
            if (statusRD == 'idle') {
                toggle1();
            }
        } else {
            const resp = await dispatch(createOrderAsync(data));

            if (resp.payload === undefined) {
                showAlert('warning', 'số lượng trong kho đã hết');
            }
            if (statusRD == 'idle') {
                toggle1();
            }
        }
        dispatch(getOrderInTableListAsync(tableID));
    }
    const handleUpdatepriceItem = async () => {
        if (priceProduct != null) {
            const data = {
                id: orderID,
                subTotal: priceProduct
            }
            await dispatch(updatePriceOrderAsync({ data }));
            const updatedOrders = order.map((item) => {
                if (item.orderID === orderID) {
                    return { ...item, price: priceProduct };
                }
                return item;
            });

            setOrder(updatedOrders);
            dispatch(getOrderInTableListAsync(tableID));
        }
        toggle3();
    }

    const handleMinusOrder = async (item: any) => {
        console.log(" item::", item);
        if (item.quantity <= 0) {
            showAlert('warning', 'Không thể giảm số lượng món ăn');
            return;
        }
        setOrderID(item.orderID);
        const data = {
            userID: userID,
            tableID: tableID,
            productID: item.productID,
            quantity: item.quantity - 1,
        }
        const resp = await dispatch(updateOrderAsync({ data, orderID }));
        dispatch(getOrderInTableListAsync(tableID));
    }

    const deleteItem = async (id: any) => {
        await dispatch(deleteOrderAsync(id));
        if (statusRD === 'idle') {
            showAlert("success", "Đã xóa món khỏi order");
            dispatch(getOrderInTableListAsync(tableID));

        }
        toggle();
    }

    const deleteAllItem = async () => {
        await dispatch(deleteAllOrderAsync(tableID));
        if (statusRD === 'idle') {
            showAlert("success", "Đã xóa món khỏi order");
            dispatch(getOrderInTableListAsync(tableID));
            toggleDelAll();
        }
    }

    const handleThanhToan = async () => {
        const data = {
            id: tableID,
            payMethod
        }
        await dispatch(payBillAsync(data)); //step 1:  gọi hàm thêm xoá sửa thì cho await vô 
        showAlert("success", "Thanh toán thành công");
        dispatch(getOrderInTableListAsync(tableID));//step 2: sau đó gọi hàm getList
        toggle2();
    }

    const findTenDVT = (idDVT: any) => {
        if (listDVTList && listDVTList.length > 0) {
            const dvt: any = listDVTList.find((item: any) => item.id === idDVT);
            if (dvt) {
                return dvt.tenDVT
            } else {
                return idDVT
            }
        } else {
            return idDVT
        }
    }

    const handleSelectedCategoryChange = (event: any) => {
        const selectedValue = event.target.value;
        setItemCategory(selectedValue);
        setSearchName('')
        if (selectedValue === '0') {
            dispatch(getMenuListAsync());
        } else {
            dispatch(getFilterCategoryListAsync(selectedValue))
        }
    }

    const onSearchChange = (searchName: any) => {
        setSearchName(searchName);
        if (searchName.trim() !== '') {
            dispatch(getSearchMenuListAsync(searchName));
            setItemCategory('0')
        } else {
            dispatch(getMenuListAsync());
        }
    }
    return (
        <div style={{ display: 'flex' }}>
            <div style={{ width: '38%', padding: '10px', height: '100vh' }}>
                <div className="my-3" style={{ display: "flex", justifyContent: 'space-between' }}>
                    <div style={{ width: '60%' }}>
                        <input type="text"
                            value={searchName}
                            onChange={(e) => onSearchChange(e.target.value)} placeholder='Nhập tên món' className='form-control' />
                    </div>
                    <div style={{ width: '35%' }}>
                        <select
                            className="form-control"
                            id="dvt"
                            value={itemCategory}
                            onChange={handleSelectedCategoryChange}>
                            <option value="0">Chọn loại món</option>
                            {listCategory && listCategory.length > 0 ? listCategory.map((item: any, id: number) => (
                                <option value={item.id} key={id}>{item.name}</option>
                            )) : ""}
                        </select>
                    </div>
                </div>
                {listItem && listItem.length > 0 ? (
                    <div className="grid-container">
                        {listItem.map((item, id) => (
                            <div
                                className="grid-item"
                                key={id}
                                style={{ backgroundImage: `url(${item && item.imgUrl ? item.imgUrl : ''})`, height: '150px', padding: '0px', display: 'flex', alignItems: 'end', borderRadius: "10px" }}
                                onClick={() => {
                                    handlePlusOrder(item);
                                }}
                            >
                                <div style={{ width: '100%', padding: '10px 0px 10px 0px', backgroundColor: 'white', opacity: '0.9', borderRadius: "0px 0px 10px 10px" }}>
                                    <h6 className='m-0'>{item.name}</h6>
                                </div>
                            </div>
                        ))}
                    </div>
                ) : null}
            </div>

            <div style={{ height: "100vh", width: '1px', backgroundColor: '#dad9d9' }}></div>

            <div style={{ marginRight: '15px', border: 'none', width: '62%', height: '100vh', padding: '10px' }}>
                <div >
                    <div className="row py-3">
                        <div className="col-sm-7">
                            <div className="invoice-detail">
                                <span style={{ fontWeight: "bold" }}>Tên nhân viên : </span> {order && order.length > 0 ? order[0].userName : ""}
                            </div>
                            <div className="invoice-detail" >
                                <span style={{ fontWeight: "bold" }}>Tổng tiền : </span>  {formatMoney(caculatorTotal())} VND
                            </div>
                        </div>
                        <div className="col-sm-5">
                            <div className="date text-inverse m-t-5">
                                <span style={{ fontWeight: "bold" }}>Giờ Vào : </span>{order && order.length > 0 ? `${formatDateTime(order[0].orderDate)}` : ""}
                            </div>
                            {order.length > 0 ? (
                                <button className="btn btn-warning btn-sm" onClick={() => {
                                    toggleDelAll();
                                }}>Xóa tất cả
                                </button>
                            ) : (null)}
                        </div>
                    </div>

                </div>

                <div className="card invoice-content d-flex scroll-2">
                    <div className="table-responsive">
                        <table className="table table-invoice">
                            <thead>
                                <tr>
                                    <th style={{ fontSize: 18, fontWeight: "bold", color: "red", width: '30%' }}>Sản phẩm</th>
                                    <th className="text-center" style={{ width: "10%" }}>Giá</th>
                                    <th className="text-center" style={{ width: "20%" }}>Số lượng</th>
                                    <th className="text-center" style={{ width: "20%" }}>Tổng cộng</th>
                                    <th className="text-left" style={{ width: "10%" }}></th>
                                </tr>
                            </thead>
                            <tbody >
                                {order && order.length > 0 ? (
                                    order.map((item, index, id) => (
                                        <tr key={index}>
                                            <td style={{ color: "green", fontSize: 20 }}>
                                                <h6>{item.productName} ({findTenDVT(item.dvt)})</h6>
                                            </td>
                                            <td className="text-center" onClick={() => { openModal3(item) }}>{formatMoney(item.price_produc ? item.price_produc : item.price)}</td>
                                            <td style={{ display: 'flex', justifyContent: 'space-around', alignItems: 'center' }}>
                                                <button className='btn btn-outline-dark' onClick={() => handleMinusOrder(item)}>-</button>
                                                {item.quantity}
                                                <button className='btn btn-outline-dark' onClick={() => handlePlusOrder(item)}>+</button>
                                            </td>
                                            <td className="text-center">{formatMoney((item.price_produc !== null ? item.price_produc * item.quantity : item.subTotal))}</td>
                                            <td className="project-actions text-left ">
                                                <button className="btn btn-outline-danger" onClick={() => {
                                                    openModal(item.orderID)
                                                }}>
                                                    <i className="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    ))
                                ) : (
                                    <div style={{ position: 'relative', left: '100%' }}><img src="\img\empty-cart.png" alt="" /></div>
                                )}
                            </tbody>
                        </table>
                    </div>
                </div>

                {order.length > 0 ? (
                    <div className='card p-3 mt-1' style={{ backgroundColor: '#cddfdf5c' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                            <div style={{ display: 'flex', alignItems: 'center' }}>
                                <h6 className='m-0'>Phương thức thanh toán: </h6>
                                <select
                                    style={{ width: '110px', padding: "3px 3px", height: "30px" }}
                                    className="form-control ml-1"
                                    id="paymentMethod"
                                    value={payMethod}
                                    onChange={(e) => setPayMethod(Number(e.target.value))}
                                >
                                    <option value="1">Tiền mặt</option>
                                    <option value="2">Chuyển khoản</option>
                                </select>
                            </div>

                            <button className="btn btn-warning" onClick={() => {
                                openModal2()
                            }}>
                                <MonetizationOnIcon /> Thanh toán
                            </button>
                        </div>
                    </div>
                ) : (null)}
            </div>

            <Modal isOpen={modal} toggle={openModal}>
                <ModalHeader toggle={openModal}>{"Xác nhận xóa! "}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <p>Bạn muốn xóa món ăn này khỏi danh sách order?</p>
                        </div>

                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="primary" onClick={() => {
                        deleteItem(idItemDelete);
                    }}>
                        Xóa
                    </Button>
                    <Button color="secondary" onClick={() => openModal()}>
                        Hủy
                    </Button>
                </ModalFooter>
            </Modal>

            <Modal isOpen={modalDelAll} toggle={openModalDel}>
                <ModalHeader toggle={openModalDel}>{"Xác nhận xóa tất cả! "}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <p>Bạn muốn xóa tất cả món ăn này khỏi danh sách order này?</p>
                        </div>

                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="primary" onClick={() => {
                        deleteAllItem();
                    }}>
                        Xóa
                    </Button>
                    <Button color="secondary" onClick={() => {openModalDel()}}>
                        Hủy
                    </Button>
                </ModalFooter>
            </Modal>

            <Modal isOpen={modal2} toggle={openModal2}>
                <ModalHeader toggle={openModal2}>{"Xác nhận Thanh toán! "}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <p>Nhấn OK để thanh toán</p>
                        </div>

                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="primary" onClick={handleThanhToan}>
                        OK
                    </Button>
                    <Button color="secondary" onClick={() => openModal2()}>
                        Hủy
                    </Button>
                </ModalFooter>
            </Modal>

            {/* quantity Product order */}
            <Modal isOpen={modal3} toggle={openModal3}>
                <ModalHeader toggle={openModal3}>{"Chọn phần ! "}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <select
                                className="form-control"
                                id="price"
                                value={priceProduct}
                                onChange={(e) => {
                                    setPriceProduct(Number(e.target.value));
                                }}
                            >
                                <option value=" ">Chọn phần cho món ăn</option>
                                {listPriceOfProd && listPriceOfProd.length > 0 ? listPriceOfProd.map((item: any, id: number) => (
                                    <option value={item.product_price}>{`${item.SizeName} : ${item.product_price}`}</option>
                                )) : ""}
                            </select>
                        </div>

                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="primary" onClick={handleUpdatepriceItem}>
                        OK
                    </Button>
                    <Button color="secondary" onClick={() => toggle3()}>
                        Hủy
                    </Button>
                </ModalFooter>
            </Modal>
        </div>
    )
}