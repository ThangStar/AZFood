'use client'

import { getJWTToken, getUserFullname, getUserID, loginAsync } from '@/redux-store/login-reducer/loginSlice';
import { AppDispatch, RootState } from '@/redux-store/store';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { showAlert } from '../utils/alert/alert';
import { useRouter } from 'next/navigation';
import '../../../public/img/logo/chicken.png'

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
        <div className="login-screen row vw-100" style={{ height: '100%', alignItems: 'center', justifyContent: 'center', padding: '50px' }}>
            <div className='box-image col-md-5 d-none d-md-block' >
                <img src="/img/login-image.jpg" alt="Hình ảnh" />
            </div>
            <div className='box-login col-md-5'>
                <div className="card m-lg-4" style={{ padding: '25px' }}>
                    <div className="header-form" style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                        <div className="logo" style={{ display: 'flex', alignItems: 'center' }}>
                            <img src="/img/logo/chicken.png" alt="Hình ảnh" style={{ height: '40px' }} />
                            <h6 style={{ marginLeft: '10px' }}>AZFOOD</h6>
                        </div>
                        <h5 className="login-text">
                            Đăng nhập
                        </h5>
                    </div>

                    <div className="line" style={{ borderBottom: '1px solid #C0C0C0', margin: '15px 0 20px 0' }}></div>

                    <div className="input-group mb-3 mt-2">
                        <input
                            className="form-control"
                            type="text"
                            placeholder="Tên đăng nhập"
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
                    <div className="input-group mt-2">
                        <input
                            className="form-control"
                            type="password"
                            placeholder="Mật khẩu"
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

                    <div className="bottom-form" style={{ display: 'flex', justifyContent: 'right' }}>
                        <div style={{ display: 'flex', alignItems: 'center' }}>
                            <a style={{ fontSize: '14px', color: 'red', padding: '10px 0 20px 0' }}>Quên mật khẩu</a>
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

    )
}
export default Login;