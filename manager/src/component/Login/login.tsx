'use client'

import { getJWTToken, getUserFullname, loginAsync } from '@/redux-store/login-reducer/loginSlice';
import { AppDispatch, RootState } from '@/redux-store/store';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { showAlert } from '../alert/alert';
import { useRouter } from 'next/navigation';

const Login = () => {

    const status = useSelector((state: RootState) => state.authenticationState.status);
    const jwtToken = useSelector(getJWTToken);
    const userFullname = useSelector(getUserFullname);
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
                localStorage.setItem("token", jwtToken);
                localStorage.setItem("username", userFullname);
                showAlert("success", "Đăng nhập thành công");
                window.location.reload();
            }


        } else if (status === 'failed') {
            showAlert("error", "Đăng nhập thất bại");
        }
    }, [status, jwtToken, userFullname]);

    return (
        <div className="d-flex justify-content-center align-items-center vh-100">
            <div className="col-12 col-lg-6">
                <div className="card border-0 shadow">
                    <div className="card-body">
                        <h4 className="border-bottom pb-4 mb-4">Sign in</h4>
                        <h6 className="fs-base fw-medium">Sign in with admin account:</h6>

                        <hr className="my-4" />
                        <h6 className="fs-base mb-4">Or using email address:</h6>
                        <div className="needs-validation">
                            <div className="input-group mb-4">
                                <input
                                    className="form-control"
                                    type="text"
                                    placeholder="username"
                                    value={username}
                                    onChange={(e) => setUsername(e.target.value)}
                                    required
                                />
                            </div>
                            <div className="input-group mb-4">
                                <input
                                    className="form-control"
                                    type="password"
                                    placeholder="Password"
                                    value={password}
                                    onChange={(e) => setPassword(e.target.value)}
                                    required
                                />
                            </div>
                            <hr className="my-4" />
                            <div className="text-end">
                                <button className="btn btn-primary" onClick={handleLogin}>Sign In</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}
export default Login;