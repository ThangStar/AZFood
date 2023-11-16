'use client'

import { getJWTToken, getUserFullname, getUserID, loginAsync } from '@/redux-store/login-reducer/loginSlice';
import { AppDispatch, RootState } from '@/redux-store/store';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { showAlert } from '../utils/alert/alert';
import { useRouter } from 'next/navigation';
import '../../../public/img/logo/chicken.png'
import { Button, Modal, ModalBody, ModalFooter, ModalHeader } from 'reactstrap';
import OtpInput from 'react-otp-input';
import { checkOTP, resetPasswordAsync, sendOtpToEmailAsync, } from '@/redux-store/forgot-password-reducer/forgot-passwordSlide';


const Login = () => {

    const status = useSelector((state: RootState) => state.authenticationState.status);
    const resultSendOtp: any = useSelector((state: RootState) => state.forgotPassSate.result);
    const statusForgot = useSelector((state: RootState) => state.forgotPassSate.status);
    const isCheckForgot = useSelector((state: RootState) => state.forgotPassSate.isCheck);
    const jwtToken = useSelector(getJWTToken);
    const userFullname = useSelector(getUserFullname);
    const userID: any = useSelector(getUserID);

    const dispatch: AppDispatch = useDispatch();
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [hidePassword, setHidePassword] = useState(true)
    const [hidePassChange, setHidePassChange] = useState(true)
    const [modalForgot, setModalForgot] = useState(false);
    const [otp, setOtp] = useState('');
    const [email, setEmail] = useState('');
    const [newPass, setNewPass] = useState('');

    const router = useRouter()
    const handleLogin = async () => {
        console.log("ststtt ", status);

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
    console.log(" sttus ", status);

    useEffect(() => {
        // check hanhle forgot password
        if (statusForgot === 'failed' && isCheckForgot === 'email') {
            showAlert("error", "Không thể gửi mã otp");
        } else if (statusForgot === 'failed' && isCheckForgot === 'otp') {
            showAlert("error", "Mã otp không đúng");
        } else if (statusForgot === 'failed' && isCheckForgot === 'password') {
            showAlert("error", "Lỗi khi đổi password");
        } else if (statusForgot === 'success') {
            showAlert("success", "Đổi password thành công");
            openModalForgot()
            setOtp('')
            setEmail('')
            setNewPass('')
        }
    }, [statusForgot, isCheckForgot]);

    const toggle = () => {
        setModalForgot(!modalForgot)
    }

    const openModalForgot = () => {
        toggle()
    }

    const handleSendOtp = () => {
        dispatch(sendOtpToEmailAsync(email))
    }

    const handleCheckOtp = () => {
        dispatch(checkOTP(otp))
    }

    const handleChangePassword = () => {
        const data = {
            email: resultSendOtp?.email,
            password: newPass
        }
        dispatch(resetPasswordAsync(data))
    }

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
                            type={`${hidePassword ? "password" : "text"}`}
                            placeholder="Mật khẩu"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            required
                        />
                        <button className="btn input-group-text" onClick={() => setHidePassword(!hidePassword)}>
                            <i className={`far ${hidePassword ? "fa-eye" : "fa-eye-slash"}`}></i>
                        </button>
                    </div>

                    <div className="bottom-form" style={{ display: 'flex', justifyContent: 'right' }}>
                        <div style={{ display: 'flex', alignItems: 'center' }}>
                            <button className='btn text-danger mb-3 pe-0' style={{ fontSize: '14px' }}
                                onClick={openModalForgot}>
                                Quên mật khẩu
                            </button>
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
            {/* Modal forgot password */}
            <Modal isOpen={modalForgot} toggle1={openModalForgot}>
                <ModalHeader toggle={openModalForgot}>{"Quên mật khẩu"}</ModalHeader>
                <ModalBody>
                    <div className="form-horizontal">
                        {isCheckForgot === 'email' ?
                            <>
                                <h4 className='text-center'>Gửi mã OTP</h4>
                                <div>Chúng tôi sẽ gửi đến email của bạn một mà code. Vui lòng nhập email đã đăng ký tài khoản với chúng tôi.</div>
                                <div className="form-group row mt-4">
                                    <label className="col-sm-4 col-form-label">Địa chỉ email:</label>
                                    <div className="col-sm-8">
                                        <input
                                            className="form-control"
                                            type='email'
                                            value={email}
                                            onChange={(e) => {
                                                setEmail(e.target.value);
                                            }}
                                        />
                                    </div>
                                </div>
                            </>
                            : isCheckForgot === 'otp' ?
                                <div>
                                    <h4 className='text-center'>Xác thực OTP</h4>
                                    <div className="d-flex flex-column align-items-center mt-2">
                                        <div className='w-75 text-center mb-4'>Mã otp đã được gửi đến email {resultSendOtp?.email}. Vui lòng kiểm tra email và nhập mã otp để xác thực.</div>
                                        <OtpInput
                                            value={otp}
                                            onChange={setOtp}
                                            numInputs={6}
                                            renderSeparator={<span className='me-3' />}
                                            containerStyle={'padding: 10px'}
                                            shouldAutoFocus
                                            renderInput={(props) => <input {...props} type="number" className='otp-input' />}
                                        />
                                        <button className='mt-3 text-primary text-center'>Gửi lại mã otp</button>
                                    </div>
                                </div>
                                :
                                <>
                                    <h4 className='text-center'>Đổi mật khẩu</h4>
                                    <div className='text-center'>Nhập mật khẩu mới. Mật khẩu phải tối thiểu 6 ký tự</div>
                                    <div className="form-group row mt-4">
                                        <label className="col-sm-4 col-form-label">Mật khẩu mới:</label>
                                        <div className="col-sm-8 input-group">
                                            <input
                                                className="form-control"
                                                type={`${hidePassChange ? "password" : "text"}`}
                                                placeholder="Mật khẩu mới"
                                                value={newPass}
                                                onChange={(e) => setNewPass(e.target.value)}
                                                required
                                            />
                                            <button className="btn input-group-text" onClick={() => setHidePassChange(!hidePassChange)}>
                                                <i className={`far ${hidePassChange ? "fa-eye" : "fa-eye-slash"}`}></i>
                                            </button>
                                        </div>
                                    </div>
                                </>
                        }
                    </div>
                </ModalBody>
                <ModalFooter>
                    {isCheckForgot === "email" ?
                        <Button color="primary" onClick={() => {
                            handleSendOtp()
                        }}>
                            Gửi mã otp
                        </Button>
                        : isCheckForgot === 'otp' ?
                            <Button disabled={otp.length !== 6} color="primary" onClick={() => {
                                handleCheckOtp()
                            }}>
                                Xác nhận
                            </Button>
                            :
                            <Button color="primary" onClick={() => {
                                handleChangePassword()
                            }}>
                                Lưu mật khẩu
                            </Button>
                    }
                    <Button color="secondary" onClick={() => {
                        openModalForgot()
                    }}>
                        Hủy
                    </Button>
                </ModalFooter>
            </Modal>
        </div>
    )
}
export default Login;