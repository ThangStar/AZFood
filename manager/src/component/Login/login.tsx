'use client'

import { getJWTToken, getUserFullname, getUserID, loginAsync } from '@/redux-store/login-reducer/loginSlice';
import { AppDispatch, RootState } from '@/redux-store/store';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { showAlert } from '../utils/alert/alert';
import { useRouter } from 'next/navigation';

const Login = () => {

    const status = useSelector((state: RootState) => state.authenticationState.status);
    const jwtToken = useSelector(getJWTToken);
    const userFullname = useSelector(getUserFullname);
    const userID: any = useSelector(getUserID);

    const dispatch: AppDispatch = useDispatch();
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const router = useRouter();
    const handleLogin = async () => {
        await dispatch(loginAsync({ username, password }));
    };
    useEffect(() => {
        if (status === 'success') {
            if (jwtToken != null && jwtToken !== "") {
                const user: any = {
                    userFullname,
                    userID
                }
                const userJSON = JSON.stringify(user);
                localStorage.setItem("token", jwtToken);
                localStorage.setItem("user", userJSON);
                showAlert("success", "Đăng nhập thành công");
                window.location.reload();
            }


        } else if (status === 'failed') {
            showAlert("error", "Đăng nhập thất bại");
        }
    }, [status, jwtToken, userFullname]);

    return (

        <div className="hold-transition login-page">
            <div className="login-box">
                <div className="login-logo">
                    <a href="../../index2.html"><b>Quản Lý Nhà Hàng </b></a>
                </div>
                <div className="card">
                    <div className="card-body login-card-body">
                        <p className="login-box-msg">Đăng nhập để sử dụng hệ thống</p>

                        <div>
                            <div className="input-group mb-3">
                                <input
                                    className="form-control"
                                    type="text"
                                    placeholder="username"
                                    value={username}
                                    onChange={(e) => setUsername(e.target.value)}
                                    required
                                />
                                <div className="input-group-append">
                                    <div className="input-group-text">
                                        <span className="fas fa-user"></span>
                                    </div>
                                </div>
                            </div>
                            <div className="input-group mb-3">
                                <input
                                    className="form-control"
                                    type="password"
                                    placeholder="Password"
                                    value={password}
                                    onChange={(e) => setPassword(e.target.value)}
                                    required
                                />
                                <div className="input-group-append">
                                    <div className="input-group-text">
                                        <span className="fas fa-lock"></span>
                                    </div>
                                </div>
                            </div>
                            <div className="row">


                                <div className="col-12">
                                    <button type="submit" className="btn btn-primary btn-block" onClick={handleLogin}>
                                        Đăng nhập
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}
export default Login;