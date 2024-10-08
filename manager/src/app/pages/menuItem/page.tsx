'use client'
import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useLayoutEffect } from 'react';
import Link from "next/link";
import { createMenuItemAsync, deleteMenuItemAsync, getCategoryList, getCategoryListAsync, getFilterCategoryListAsync, getMenuItemListAsync, getMenuItemtList, getPriceForSize, getPriceList, getSearchMenuListAsync, updateStatusMenuItem } from '@/redux-store/menuItem-reducer/menuItemSlice';
import { AppDispatch } from '@/redux-store/store';
import { Modal, ModalHeader, ModalBody, ModalFooter, Button, Input, Label } from 'reactstrap';
import { getDVTList, getDvtListAsync, nhapHangAsync } from '@/redux-store/kho-reducer/nhapHangSlice';
import { showAlert } from '@/component/utils/alert/alert';
import formatMoney from '@/component/utils/formatMoney';
import Loading from '@/component/Loading/loading';
import LoadingAdd from '@/component/Loading/LoddingAdd';


export default function MunuItems() {
    const dispatch: AppDispatch = useDispatch();
    const menuItemList: any = useSelector(getMenuItemtList);
    const categoryList: any = useSelector(getCategoryList);
    const dvtList: any = useSelector(getDVTList);
    const priceList: any = useSelector(getPriceList);


    const [menuItems, setMenuItems] = useState<any[]>([]);
    const [listPriceProd, setListPriceProd] = useState<any[]>([]);
    const [modal, setModal] = useState(false);
    const [modal1, setModal1] = useState(false);
    const [modalStatus, setModalStatus] = useState(false);
    const [itemName, setItemName] = useState("");
    const [itemPrice, setItemPrice] = useState("");
    const [itemDVT, setItemDVT] = useState("");
    const [status, setStatus] = useState("");
    const [itemCategory, setItemCategory] = useState("");
    const [idItemDelete, setIdItemDelete] = useState<number>(0);
    const [idItem, setIdItem] = useState<number>();
    const [listCategory, setListCategory] = useState<string[]>([]);
    const [listDvt, setListDvt] = useState<string[]>([]);
    const [currentPage, setCurrentPage] = useState(1);
    const [searchName, setSearchName] = useState("")
    const [isEdit, setIsEdit] = useState(false);
    const [image, setImage] = useState("");
    const [selectedCategory, setSelectedCategory] = useState("0");
    const [itemQuantity, setItemQuantity] = useState("");
    const [isLoading, setIsLoading] = useState(false);

    const [file, setFile] = useState<File | null>(null);
    const totalPages = menuItemList ? menuItemList.totalPages : 1;
    useEffect(() => {
        const fetchData = async () => {
            handlePageChange(currentPage);
            await dispatch(getCategoryListAsync());
            await dispatch(getDvtListAsync());
            await dispatch(getPriceForSize());
        }
        fetchData();
    }, [dispatch, currentPage]);

    useEffect(() => {

        if (menuItemList && menuItemList.data) {
            setMenuItems(menuItemList.data);
        }
        if (categoryList && categoryList.resultRaw) {
            setListCategory(categoryList.resultRaw);
        }
        if (dvtList && dvtList.resultRaw) {
            setListDvt(dvtList.resultRaw);
        }
        if (priceList && priceList.resultRaw) {
            setListPriceProd(priceList.resultRaw);
        }
    }, [menuItemList, categoryList, dvtList, dispatch, priceList]);

    const handlePageChange = (page: number) => {
        setCurrentPage(page);
        dispatch(getMenuItemListAsync(page));
    }

    const toggle = () => setModal(!modal);
    const openModal = () => {
        toggle();
        setDataForm("");
    }
    const setDataForm = (data: any) => {
        setIdItem(data.id);
        setItemName(data.name);
        setItemPrice(data.price);
        setItemCategory(data.category);
        setItemDVT(data.dvtID);
        setStatus(data.status);
        setImage(data.imgUrl);
    }

    const handleCancel = () => {
        setIdItem(0);
        setItemName("");
        setItemPrice("");
        setItemCategory("");
        setItemDVT("");
        setStatus("");
        setImage("");
    };

    const toggle1 = () => setModal1(!modal1);
    const openModal1 = (id: any = null) => {
        setIdItemDelete(id);
        toggle1();
    }

    const addMenuItem = async () => {
        try {
            setIsLoading(true);

            const data = {
                name: itemName,
                price: itemPrice,
                category: itemCategory,
                status: status,
                dvtID: itemDVT,
                id: idItem,
                quantity: itemQuantity,
                file
            };
            // vailable
            const isNonNegativeNumber = /^\d+(\.\d+)?$/.test(itemPrice);
            if (itemCategory === undefined || itemCategory === "" ||
                itemName === undefined || itemName.trim().length === 0 ||
                itemPrice === undefined || !isNonNegativeNumber ||
                itemDVT === undefined || itemDVT === "") {
                showAlert("error", "Bạn cần điền đầy đủ thông tin");
                return;
            }

            await dispatch(createMenuItemAsync(data));
            setDataForm("");
            handlePageChange(currentPage);
            showAlert("success", " Thêm món thành công");
            setItemQuantity('0');
            toggle();
        } catch (error) {
            console.error('Error adding menu item:', error);
            setIsLoading(false);
        } finally {
            setIsLoading(false);
        }

    }

    const deleteItem = async (id: number) => {
        try {
            const resultAction = await dispatch(deleteMenuItemAsync(id)).unwrap();
            showAlert("success", "Xóa món ăn thành công");
            console.log("Payload:", resultAction.payload);
        } catch (error) {
            showAlert("error", "Món ăn này đang được order");
            console.error("Delete failed:", error);
        }
        handlePageChange(currentPage);
        toggle1();
    };

    const onSearchChange = (searchName: any) => {
        setSearchName(searchName);
        if (searchName.trim() !== '') {
            dispatch(getSearchMenuListAsync(searchName));
            setSelectedCategory('0')
        } else {
            handlePageChange(currentPage)
        }
    }
    const handleImageUpload = (files: any) => {
        if (files && files.length > 0) {
            const reader = new FileReader();
            setFile(files[0]);
            reader.onload = (e: any) => {
                setImage(e.target.result);
            };
            reader.readAsDataURL(files[0]);
        }
    };

    const handleImageClear = () => {
        setFile(null);
        // setImageFile(null);
        setImage("");
    };

    const handleSelectedCategoryChange = (event: any) => {
        const selectedValue = event.target.value;
        setSelectedCategory(selectedValue);
        setSearchName('')
        if (selectedValue === '0') {
            handlePageChange(currentPage)
        } else {
            dispatch(getFilterCategoryListAsync(selectedValue))
        }
    }

    const handleUpdateStatusMenuItem = (id: any, status: number) => {
        dispatch(updateStatusMenuItem({ id: id, status: status }))
        handlePageChange(currentPage)
    }
    const toggleStatus = () => setModalStatus(!modalStatus)
    const openModalStatus = () => {
        toggleStatus()
    }
    return (
        <>
            {isLoading && <LoadingAdd />}
            <div className="container-fluid">
                <div className="p-3" style={{ display: 'flex', justifyContent: 'space-between', borderBottom: '1.5px solid rgb(195 211 210)' }}>
                    <h3 className='m-0' style={{ height: '40px' }}>Danh sách món</h3>
                    <div >
                        <button className="btn btn-success" onClick={() => {
                            openModal()
                        }}><i className="fas fa-plus-circle mx-0"></i>Thêm món ăn</button>
                        <Link href="/pages/menuItem/menuItemDetail" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                            <button className="btn btn-warning"><i className="fas fa-plus-circle mx-0"></i>Quản lý phần</button>
                        </Link>

                    </div>
                </div>
            </div>

            <div className="content">
                <div className='row' style={{ padding: '20px 8px 20px 25px', width: "100%", justifyContent: 'space-between' }}>
                    <div className="col-sm-9 p-0">
                        <div className="input-group">
                            <input
                                type="text"
                                value={searchName}
                                onChange={(e) => onSearchChange(e.target.value)}
                                placeholder="Tìm kiếm món ăn..."
                                className='form-control'
                            />
                            <span className='input-group-text bg-success text-bg-success'><i className="fas fa-search"></i></span>
                        </div>
                    </div>
                    <div className="col-sm-2" style={{ display: 'flex', padding: '0' }}>
                        <select
                            className='form-control'
                            value={selectedCategory}
                            onChange={handleSelectedCategoryChange}
                        >
                            {listCategory && listCategory.length > 0 &&
                                listCategory.map((item: any) => (
                                    <option key={item.id} value={item.id}>
                                        {item.name}
                                    </option>
                                ))
                            }
                        </select>
                    </div>

                </div>
                {/* table */}
                <div className="card card-body border-0 p-0 mx-3" style={{ height: '70vh', overflowY: 'auto' }}>
                    <table className="table table-striped projects">
                        <thead >
                            <tr >
                                <th style={{ width: "5vh" }}>
                                    MSP
                                </th>
                                <th style={{ width: "20%" }}>
                                    Tên Món
                                </th>
                                <th>
                                    Giá(vnd)
                                </th>
                                <th>
                                    Đơn vị Tính
                                </th>
                                <th style={{ width: "10%" }}>
                                    Loại món
                                </th>
                                <th>
                                    Tồn Kho
                                </th>
                                <th style={{ width: "16%" }} className="text-center">
                                    Tùy Chỉnh
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            {menuItems && menuItems.length > 0 ? menuItems.map((item: any, i: number) => (
                                <tr key={item && item.id ? item.id : null}>
                                    <td style={{ textAlign: 'center' }}>
                                        {item.id}
                                    </td>
                                    <td>
                                        <div className='d-flex align-items-center'>
                                            {item && item.imgUrl ?
                                                <img alt="món ăn" style={{ height: 40, width: 40, objectFit: 'cover' }} src={item.imgUrl} />
                                                :
                                                <img src="" alt=" món ăn" style={{ height: 40 }} />
                                            }
                                            <div style={{ marginLeft: '10px' }}>
                                                {item && item.name ? item.name : null}
                                            </div>
                                        </div>
                                    </td>
                                    <td className="project_progress" style={{}}>
                                        {item && item.price ? `${formatMoney(item.price)} ` : 'Tính theo phần'}
                                    </td>
                                    <td className="project_progress">
                                        {item && item.dvt_name ? item.dvt_name : null}
                                    </td>
                                    <td className="project_progress">
                                        {item && item.category_name ? item.category_name : ""}
                                    </td>

                                    <td className="project_progress">
                                        {item && item.status === 1 ?
                                            <button onClick={() => {
                                                openModalStatus()
                                                setDataForm(item)
                                            }}>Còn hàng</button>
                                            : item.status == 2 ?
                                                <button onClick={() => {
                                                    handleUpdateStatusMenuItem(item.id, 1)
                                                }}>Hết hàng</button>
                                                : item.quantity == null ? "Hết hàng" : item.quantity == 0 ? "Hết hàng" : item.quantity}
                                    </td>
                                    <td className="project-actions text-right">
                                        <div className="d-flex justify-content-between " >
                                            {/* <a className="btn btn-primary btn-sm" href="#">
                                                        <i className="fas fa-folder mr-1"></i> View
                                                    </a> */}
                                            <button className="btn btn-success btn-sm pd-5" onClick={() => {
                                                openModal();
                                                setIsEdit(true);
                                                setDataForm(item)
                                            }}>
                                                <i className="fas fa-pencil-alt"></i> Sửa
                                            </button>
                                            <button className="btn btn-danger btn-sm me-2" onClick={() => {
                                                openModal1(item.id)
                                                setItemName(item?.name)
                                            }}>
                                                <i className="fas fa-trash"></i> Xóa
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            )) :
                                <>Loading</>
                            }
                        </tbody>
                    </table>
                </div>
                {/* pagination */}
                <div className="card-footer bg-white p-0">
                    <div className="d-flex justify-content-center align-items-center">
                        <ul className="pagination">
                            <li className={`page-item ${currentPage === 1 ? 'disabled' : ''}`}>
                                <button
                                    className="page-link"
                                    onClick={() => handlePageChange(currentPage - 1)}
                                >
                                    &#60;
                                </button>
                            </li>
                            {Array.from({ length: totalPages }, (_, i) => (
                                <li
                                    className={`page-item ${currentPage === i + 1 ? 'active' : ''}`}
                                    key={i + 1}
                                >
                                    <button
                                        className="page-link"
                                        onClick={() => handlePageChange(i + 1)}
                                    >
                                        {i + 1}
                                    </button>
                                </li>
                            ))}
                            <li className={`page-item ${currentPage === totalPages ? 'disabled' : ''}`}>
                                <button
                                    className="page-link"
                                    onClick={() => handlePageChange(currentPage + 1)}
                                >
                                    &#62;
                                </button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            {/* modal add and edit */}
            <Modal isOpen={modal} toggle={openModal}>
                <ModalHeader toggle={openModal}>{!idItem ? "Thêm Món Mới" : "Sửa món"}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <label className="col-sm-3 col-form-label">Loại món </label>
                            <div className="col-sm-8">
                                <select
                                    className="form-control"
                                    id="dvt"
                                    value={itemCategory}
                                    onChange={(e) => {
                                        setItemCategory(e.target.value)
                                    }}
                                >
                                    <option value="" selected>Chọn loại món</option>
                                    {listCategory && listCategory.length > 0 ? listCategory.map((item: any, id: number) => (
                                        <option value={item.id} key={id}>{item.name}</option>
                                    )) : ""}
                                </select>
                            </div>
                        </div>
                        <>
                            <div className="form-group row">
                                <label className="col-sm-3 col-form-label">Ảnh đại diện</label>
                                <div className="col-sm-8">
                                    <input
                                        className="form-control"
                                        type='file'
                                        id="image"
                                        placeholder='Chọn ảnh '
                                        onChange={(e) => handleImageUpload(e.target.files)}

                                    />
                                    {image && typeof image === 'string' && (
                                        <div>
                                            <img src={image} width={80} height={80} alt="Selected" />
                                            <button onClick={handleImageClear} style={{ color: "red", fontSize: 12, marginLeft: 10 }}>Xoá ảnh</button>
                                        </div>
                                    )}
                                </div>
                            </div>
                            <div className="form-group row">
                                <label className="col-sm-3 col-form-label">Tên món ăn </label>
                                <div className="col-sm-8">
                                    <input
                                        className="form-control"
                                        id="name"
                                        value={itemName}
                                        onChange={(e) => {
                                            setItemName(e.target.value)
                                        }}
                                    />
                                </div>
                            </div>

                            <div className="form-group row">
                                <label className="col-sm-3 col-form-label">Giá</label>
                                <div className="col-sm-4">
                                    <input
                                        className="form-control"
                                        id="name"
                                        value={itemPrice}
                                        onChange={(e) => {
                                            setItemPrice(e.target.value)
                                        }}
                                    />
                                </div>
                                <div className="col-sm-3 ml-10 mt-2" >
                                    <Input type="checkbox"
                                        id="exampleInput"
                                        placeholder="Enter something"
                                        value={itemPrice}
                                        onChange={() => setItemPrice('0')} />
                                    <Label check>
                                        Tính theo phần
                                    </Label>
                                </div>
                            </div>

                            {itemCategory === "2" ? <>
                                <div className="form-group row">
                                    <label className="col-sm-3 col-form-label">Số Lượng</label>
                                    <div className="col-sm-8">
                                        <input
                                            className="form-control"
                                            id="quantity"
                                            type='number'
                                            value={itemQuantity}
                                            onChange={(e) => {
                                                setItemQuantity(e.target.value);
                                            }}
                                        />
                                    </div>
                                </div>
                            </> : null}

                            <div className="form-group row">
                                <label className="col-sm-3 col-form-label">Đơn vị tính</label>
                                <div className="col-sm-8">
                                    <select
                                        className="form-control"
                                        id="dvt"
                                        value={itemDVT}
                                        onChange={(e) => {
                                            setItemDVT(e.target.value)
                                        }}
                                    >
                                        <option value=" ">Chọn đơn vị tính</option>
                                        {listDvt && listDvt.length > 0 ? listDvt.map((item: any, id: number) => (
                                            <option value={item.id}>{item.tenDVT}</option>
                                        )) : ""}
                                    </select>
                                </div>
                            </div></>
                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="secondary" onClick={() => { openModal(); handleCancel() }}>
                        Hủy
                    </Button>
                    <Button color="primary" onClick={() => {
                        addMenuItem();
                    }}>
                        Lưu
                    </Button>
                </ModalFooter>
            </Modal>
            {/* modal delete */}
            <Modal isOpen={modal1} toggle={openModal1}>
                <ModalHeader toggle1={openModal1}>{"Xác nhận xóa món ăn"}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <h4>Bạn có chắc chắn muốn xóa {itemName} không? </h4>
                            <div>Sau khi xóa món ăn sẽ bị xóa vĩnh viễn khỏi thực đơn không thể khôi phực lại được nữa</div>
                        </div>
                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="secondary" onClick={() => {
                        openModal1()
                        setDataForm(" ");
                    }}>
                        Hủy
                    </Button>
                    <Button color="danger" onClick={() => {
                        deleteItem(idItemDelete);
                    }}>
                        Đồng ý xóa
                    </Button>
                </ModalFooter>
            </Modal>

            {/* modal het hang */}
            <Modal isOpen={modalStatus} toggle={openModalStatus}>
                <ModalHeader toggle={openModalStatus}>{"Xác nhận hết hàng"}</ModalHeader>
                <ModalBody>
                    <div>
                        Khi chuyển sang trạng thái hết hàng, món ăn <b>{itemName}</b> không thể order được
                    </div>
                </ModalBody>
                <ModalFooter>
                    <Button color="secondary" onClick={() => {
                        openModalStatus()
                    }}>
                        Hủy
                    </Button>
                    <Button color="danger" onClick={() => {
                        handleUpdateStatusMenuItem(idItem, 2)
                        openModalStatus()
                    }}>
                        Hết hàng
                    </Button>
                </ModalFooter>
            </Modal>
        </>
    )
}
