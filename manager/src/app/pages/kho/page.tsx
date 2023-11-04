"use client"
import { showAlert } from "@/component/utils/alert/alert";
import formatMoney from "@/component/utils/formatMoney";
import { getDVTList, getDvtListAsync, getPhieuNhapList, getPhieuNhapListAsync,getProductState, getProductList, getProductListAsync, nhapHangAsync } from "@/redux-store/kho-reducer/nhapHangSlice";
import { AppDispatch } from "@/redux-store/store";
import Link from "next/link";
import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Button, Modal, ModalBody, ModalFooter, ModalHeader } from "reactstrap";

export default function Kho() {
    const dispatch: AppDispatch = useDispatch();
    const phieuNhapList: any = useSelector(getPhieuNhapList);
    const DVTList: any = useSelector(getDVTList);
    const ProductList: any = useSelector(getProductList);
    const status: any = useSelector(getProductState);

    const [phieuNhaps, setPhieuNhaps] = useState<any[]>([]);
    const [dvts, setDvts] = useState<any[]>([]);
    const [products, setProducts] = useState<any[]>([]);

    const [modal, setModal] = useState(false);
    const [soLuong, setSoLuong] = useState("");
    const [donGia, setDonGia] = useState("");
    const [dvtID, setDvtID] = useState("");
    const [productID, setProductID] = useState("");
    const [searchName, setSearchName] = useState("")


    useEffect(() => {
        dispatch(getPhieuNhapListAsync());
        dispatch(getDvtListAsync());
        dispatch(getProductListAsync());
    }, [dispatch]);
    useEffect(() => {

        if (phieuNhapList && phieuNhapList.resultRaw) {
            setPhieuNhaps(phieuNhapList.resultRaw);
        }
        if (DVTList && DVTList.resultRaw) {
            setDvts(DVTList.resultRaw);
        }
        if (ProductList) {
            setProducts(ProductList);
        }
    }, [phieuNhapList, dispatch]);
    const toggle = () => setModal(!modal);
    const openModal = (data: any = null) => {
        toggle();
    }
    const handleUpdate = async () => {
        const data = {
            productID: productID,
            soLuong: soLuong,
            donGia: donGia,
            dvtID: dvtID
        }
        await dispatch(nhapHangAsync(data));
        if (status == 'idle') {
            showAlert("success", "Thêm số lượng sản phẩm thành công ");
            dispatch(getPhieuNhapListAsync());
            openModal();
        } else {
            showAlert("error", "Thêm số lượng sản phẩm thất bại ");
        }
    }
    const onSearchChange = (searchName: any) => {

    }

    return (
        <>
            <div>
                <div className="container-fluid">
                    <div className="p-3" style={{ display: 'flex', justifyContent: 'space-between', borderBottom: '1.5px solid rgb(195 211 210)' }}>
                        <h3 className='m-0' style={{ height: '40px' }}>Hóa đơn nhập hàng</h3>
                        <button className="btn btn-success" onClick={() => { openModal() }}>Nhập hàng</button>
                    </div>
                </div>

                <div className="content px-3">
                    <div className="py-3" style={{ border: 'none', display: 'flex', justifyContent: 'end' }}>
                        <div className="card-tools flex items-center">
                            <form role="search">
                                <input
                                    type="text"
                                    value={searchName}
                                    onChange={(e) => onSearchChange(e.target.value)}
                                    placeholder="Tìm kiếm..."
                                    className='form-control'
                                />
                            </form>
                        </div>
                    </div>
                    <div className="card p-0">
                        <table className="table table-striped projects">
                            <thead>
                                <tr>
                                    <th style={{ width: "1%" }}>
                                        STT
                                    </th>
                                    <th style={{ width: "20%" }}>
                                        Tên hàng
                                    </th>
                                    <th style={{ width: "10%" }}>
                                        Số lượng
                                    </th>
                                    <th>
                                        Đơn giá
                                    </th>
                                    <th>
                                        Đơn vị tính
                                    </th>
                                    <th>
                                        Ngày nhập
                                    </th>


                                </tr>
                            </thead>
                            <tbody>
                                {phieuNhaps && phieuNhaps.length > 0 ? phieuNhaps.map((item: any, i: number) => (
                                    <tr key={item && item.id ? item.id : null}>
                                        <td>
                                            {i + 1}
                                        </td>
                                        <td>
                                            <a>
                                                {item && item.name ? item.name : null}
                                            </a>
                                            <br />
                                        </td>
                                        <td className="project_progress">
                                            {item && item.soLuong ? item.soLuong : null}
                                        </td>
                                        <td className="project_progress">
                                            {item && item.donGia ? formatMoney(item.donGia) : ""}
                                        </td>
                                        <td className="project_progress">
                                            {item && item.tenDVT ? item.tenDVT : null}
                                        </td>
                                        <td className="project_progress">
                                            {item && item.ngayNhap ? item.ngayNhap : null}
                                        </td>

                                    </tr>
                                )) : ""}


                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <Modal isOpen={modal} toggle={openModal}>
                <ModalHeader toggle={openModal}>{"Nhập thông tin hàng hóa"}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <label className="col-sm-4 col-form-label">Tên hàng </label>
                            <div className="col-sm-8">

                                <select
                                    className="form-control"
                                    id="productID"
                                    value={productID}
                                    onChange={(e) => {
                                        setProductID(e.target.value);
                                    }}
                                ><option value="">Chọn hàng nhập</option>
                                    {products && products.length > 0 ? products.map((item: any, id: number) => (
                                        <option key={item.id} value={item.id}>{item.name}</option>
                                    )) : ""}
                                </select>

                            </div>
                        </div>
                        <div className="form-group row">
                            <label className="col-sm-4 col-form-label">Số lượng </label>
                            <div className="col-sm-8">
                                <input
                                    type="text"
                                    className="form-control"
                                    id="quantity"
                                    value={soLuong}
                                    onChange={(e) => {
                                        setSoLuong(e.target.value);
                                    }} />

                            </div>
                        </div>
                        <div className="form-group row">
                            <label className="col-sm-4 col-form-label">Đơn giá</label>
                            <div className="col-sm-8">

                                <input
                                    type="text"
                                    className="form-control"
                                    id="donGia"
                                    value={donGia}
                                    onChange={(e) => {
                                        setDonGia(e.target.value);
                                    }} />

                            </div>
                        </div>
                        <div className="form-group row">
                            <label className="col-sm-4 col-form-label">Đơn vị tính</label>
                            <div className="col-sm-8">

                                <select
                                    className="form-control"
                                    id="department"
                                    value={dvtID}
                                    onChange={(e) => {
                                        setDvtID(e.target.value);
                                    }}
                                >
                                    <option value="">Chọn đơn vị tính</option>
                                    {dvts && dvts.length > 0 ? dvts.map((item: any, id: number) => (
                                        <option value={item.id}>{item.tenDVT}</option>


                                    )) : ""}
                                </select>

                            </div>
                        </div>
                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="primary" onClick={handleUpdate}>
                        Lưu
                    </Button>
                    <Button color="secondary" onClick={() => openModal()}>
                        Hủy
                    </Button>
                </ModalFooter>
            </Modal>
        </>
    )
}
