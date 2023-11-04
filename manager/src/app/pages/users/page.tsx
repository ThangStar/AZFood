'use client'
import { showAlert } from '@/component/utils/alert/alert';
import { AppDispatch } from '@/redux-store/store';
import { createUserListAsync, getStatusUserState, getUserList, getUserListAsync } from '@/redux-store/user-reducer/userSlice';
import Image from 'next/image'
import Link from 'next/link';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Modal, ModalHeader, ModalBody, ModalFooter, Button } from 'reactstrap';

export default function User() {
    const dispatch: AppDispatch = useDispatch();
    const userList: any = useSelector(getUserList);
    const status: any = useSelector(getStatusUserState);
    const [users, setUsers] = useState<any[]>([]);
    const [modal1, setModal1] = useState(false);
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [name, setName] = useState("");
    const [phoneNumber, setPhoneNumber] = useState("");
    const [email, setEmail] = useState("");
    const [address, setAddress] = useState("");
    const [birtDay, setBirtDay] = useState("");
    const [idUser, setIdUser] = useState("");
    const [isEdit, setIsEdit] = useState(false);
    const role = 'user';

    const toggle1 = () => setModal1(!modal1);
    const openModal1 = () => {
        toggle1();
    }
    useEffect(() => {
        dispatch(getUserListAsync());
    }, [dispatch]);
    useEffect(() => {
        if (userList && userList.resultRaw) {
            setUsers(userList.resultRaw);
        }
    }, [userList]);
    const handleAddUser = () => {
        const user = {
            username,
            password,
            name,
            role,
            phoneNumber,
            birtDay,
            address,
            email
        }
        dispatch(createUserListAsync(user));
        if (status == 'idle') {
            showAlert("success", "Thêm nhân viên mới thành công ");
            dispatch(getUserListAsync());
            openModal1();
        } else {
            showAlert("error", "Thêm nhân viên mới  bại ");
        }
    }
    const setDataForm = (item: any) => {
        if (item) {
            setUsername(item.username);
            setPassword(item.password);
            setName(item.name);
            setPhoneNumber(item.phoneNumber);
            setEmail(item.email);
            setAddress(item.address);
            setBirtDay(item.birtDay);
            setIdUser(item.id);
            setIsEdit(true);
        }
    }
    return (
        <div className='content scroll'>
            <div style={{ border: 'none' }}>
                <div className="container-fluid" style={{}}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', borderBottom: '1.5px solid rgb(195 211 210)'}} className='p-3'>
                        <div className="col-sm-6 p-0">
                            <h3 style={{ height: '40px', margin: '0px' }}>Danh sách Nhân viên</h3>
                        </div>
                        <div className="">
                            <button className="btn btn-success" onClick={openModal1}>Thêm nhân viên</button>
                        </div>
                    </div>
                </div>

                <div className="content m-3">
                    <div className="">
                        <div className="card card-body">
                            <table className="table table-striped projects">
                                <thead>
                                    <tr>
                                        <th style={{ width: "1%" }}>
                                            STT
                                        </th>
                                        <th style={{ width: "20%" }}>
                                            Tên nhân viên
                                        </th>
                                        <th style={{ width: "10%" }}>
                                            Hình ảnh
                                        </th>
                                        <th>
                                            Địa chỉ
                                        </th>
                                        <th>
                                            Số điện thoại
                                        </th>
                                        <th>
                                            Email
                                        </th>
                                        <th style={{ width: "15%" }} className="text-center">
                                            
                                        </th>

                                    </tr>
                                </thead>
                                <tbody>
                                    {users && users.length > 0 ? users.map((item: any, i: number) => (
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
                                            <td>
                                                <img alt="user" style={{ width: 60, height: 60 }} src={item && item.imgUrl ? item.imgUrl : ""} />
                                            </td>
                                            <td className="project_progress">
                                                {item && item.address ? item.address : null}
                                            </td>
                                            <td className="project_progress">
                                                {item && item.phoneNumber ? item.phoneNumber : ""}
                                            </td>
                                            <td className="project_progress">
                                                {item && item.email ? item.email : null}
                                            </td>
                                            <td className="project-actions text-right">
                                                <div className="d-flex justify-content-between " >
                                                    <a className="btn btn-primary btn-sm" href="#">
                                                        <i className="fas fa-folder">
                                                        </i>
                                                        View
                                                    </a>
                                                    <button className="btn btn-success btn-sm pd-5" onClick={() => {
                                                        openModal1();
                                                        setDataForm(item);
                                                        setIsEdit(true);
                                                    }}>
                                                        <i className="fas fa-pencil-alt"></i>

                                                        Edit

                                                    </button>
                                                    <button className="btn btn-danger btn-sm" >
                                                        <i className="fas fa-trash"></i> Delete
                                                    </button>
                                                </div>

                                            </td>
                                        </tr>
                                    )) : ""}


                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
                <Modal isOpen={modal1} toggle1={openModal1}>
                    <ModalHeader toggle1={openModal1}>{"Thêm nhân viên mới"}</ModalHeader>
                    <ModalBody>
                        <form className="form-horizontal">
                            <div className="form-group row">
                                <label className="col-sm-4 col-form-label">Tên nhân viên</label>
                                <div className="col-sm-8">

                                    <input
                                        className="form-control"
                                        id="name"
                                        value={name}
                                        onChange={(e) => {
                                            setName(e.target.value)
                                        }}
                                    />


                                </div>
                            </div>
                            <div className="form-group row">
                                <label className="col-sm-4 col-form-label">Tên tài khoản</label>
                                <div className="col-sm-8">

                                    <input
                                        className="form-control"
                                        id="username"
                                        value={username}
                                        onChange={(e) => {
                                            setUsername(e.target.value)
                                        }}
                                    />


                                </div>
                            </div>
                            <div className="form-group row">
                                <label className="col-sm-4 col-form-label">Mật khẩu</label>
                                <div className="col-sm-8">

                                    <input
                                        className="form-control"
                                        id="name"
                                        value={password}
                                        onChange={(e) => {
                                            setPassword(e.target.value)
                                        }}
                                    />


                                </div>
                            </div>
                            <div className="form-group row">
                                <label className="col-sm-4 col-form-label">Số điện thoại</label>
                                <div className="col-sm-8">

                                    <input
                                        className="form-control"
                                        id="name"
                                        value={phoneNumber}
                                        onChange={(e) => {
                                            setPhoneNumber(e.target.value)
                                        }}
                                    />


                                </div>
                            </div>
                            {isEdit && isEdit === true ? <>
                                <div className="form-group row">
                                    <label className="col-sm-4 col-form-label">Email</label>
                                    <div className="col-sm-8">

                                        <input
                                            className="form-control"
                                            id="email"
                                            value={email}
                                            onChange={(e) => {
                                                setEmail(e.target.value)
                                            }}
                                        />


                                    </div>
                                </div>
                                <div className="form-group row">
                                    <label className="col-sm-4 col-form-label">Địa chỉ</label>
                                    <div className="col-sm-8">

                                        <input
                                            className="form-control"
                                            id="address"
                                            value={address}
                                            onChange={(e) => {
                                                setAddress(e.target.value)
                                            }}
                                        />


                                    </div>
                                </div>
                                <div className="form-group row">
                                    <label className="col-sm-4 col-form-label">Sinh nhật</label>
                                    <div className="col-sm-8">

                                        <input
                                            className="form-control"
                                            id="birthDay"
                                            value={birtDay}
                                            onChange={(e) => {
                                                setBirtDay(e.target.value)
                                            }}
                                        />


                                    </div>
                                </div>
                            </> : ""}


                        </form>
                    </ModalBody>
                    <ModalFooter>
                        <Button color="primary" onClick={handleAddUser}>
                            Lưu
                        </Button>
                        <Button color="secondary" onClick={() => openModal1()}>
                            Hủy
                        </Button>
                    </ModalFooter>
                </Modal>
            </div>
        </div>
    )
}
