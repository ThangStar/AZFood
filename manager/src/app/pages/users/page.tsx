'use client'
import { AppDispatch } from '@/redux-store/store';
import { getUserList, getUserListAsync } from '@/redux-store/user-reducer/userSlice';
import Image from 'next/image'
import Link from 'next/link';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';

export default function User() {
    const dispatch: AppDispatch = useDispatch();
    const userList: any = useSelector(getUserList);
    const [users, setUsers] = useState<any[]>([]);

    useEffect(() => {

        dispatch(getUserListAsync());
    }, [dispatch]);
    useEffect(() => {

        if (userList && userList.resultRaw) {
            setUsers(userList.resultRaw);
        }
    }, [userList]);




    return (
        <>
        <div className="main-header card" >
            <div className="card-header">
                <div className="container-fluid">
                    <div className="row mb-2">
                        <div className="col-sm-6">
                            <h1>Danh sách Nhân viên</h1>
                        </div>
                        <div className="col-sm-6">
                            <ol className="breadcrumb float-sm-right">
                                <li className="breadcrumb-item"><a href="#">Home</a></li>
                                <li className="breadcrumb-item active">Danh sách nhân viên</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <div className="content">

                <div className="card">
                    <div className="card-header">
                        <button className="btn btn-success">Thêm nhân viên</button>

                        <div className="card-tools">
                            <button type="button" className="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                <i className="fas fa-minus"></i>
                            </button>
                            <button type="button" className="btn btn-tool" data-card-widget="remove" title="Remove">
                                <i className="fas fa-times"></i>
                            </button>
                        </div>
                    </div>
                    <div className="card-body p-0">
                        <table className="table table-striped projects">
                            <thead>
                                <tr>
                                    <th style={{ width: "1%" }}>
                                        STT
                                    </th>
                                    <th style={{ width: "20%" }}>
                                        Tên NV
                                    </th>
                                    <th style={{ width: "10%" }}>
                                        Hình Ảnh
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
                                        actions
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
                                                <button className="btn btn-success btn-sm pd-5" >
                                                    <i className="fas fa-pencil-alt"></i>
                                                    <Link href={`create-product?id=${item && item.id ? item.id : null}`}>
                                                        Edit
                                                    </Link>
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
            </div>
            </>
    )
}
