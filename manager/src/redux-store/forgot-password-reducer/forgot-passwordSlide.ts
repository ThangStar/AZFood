import { createAsyncThunk, createSlice, Action } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState, api } from '../store';

const serverUrl = api;

export interface ForgotPassSate {
    result: any;
    status: 'idle' | 'loading' | 'failed' | 'success';
    isCheck: 'email' | 'otp' | 'password';
}

const initialState: ForgotPassSate = {
    result: null,
    status: 'idle',
    isCheck: 'email'
};

export const sendOtpToEmailAsync = createAsyncThunk(
    'forgot-pass/send-otp',
    async (email: any) => {
        const response = await axios.post(serverUrl + '/api/auth/checkAndSendOtpToEmail',
            { email: email });
        return response.data;
    }
);


export const resetPasswordAsync = createAsyncThunk(
    'forgot-pass/reset-password',
    async (data: any) => {
        const response = await axios.post(serverUrl + '/api/auth/resetPassword',
            { email: data.email, password: data.password });
        return response.data;
    }
);

const forgotPassSlice = createSlice({
    name: 'forgot-pass',
    initialState,
    reducers: {
        checkOTP: (state, action) => {
            // So sánh mã OTP từ action với mã OTP trong result (ví dụ: result.otp)
            const { otp } = state.result
            if (action.payload === otp.toString()) {
                state.isCheck = 'password'; // Chuyển sang chế độ nhập mật khẩu mới
                state.status = 'idle'
            } else {
                state.status = 'failed'
            }
        },

        resetDataForgot: (state) => {
            state.isCheck = 'email'
            state.status = 'idle'
            state.result = null
        }
    },

    extraReducers: (builder) => {
        builder
            .addCase(sendOtpToEmailAsync.pending, (state) => {
                state.status = 'loading';
            }).addCase(sendOtpToEmailAsync.fulfilled, (state, action) => {
                state.status = 'idle';
                state.result = action.payload
                state.isCheck = 'otp'
            }).addCase(sendOtpToEmailAsync.rejected, (state) => {
                state.status = 'failed';
            })
            .addCase(resetPasswordAsync.pending, (state) => {
                state.status = 'loading';
            }).addCase(resetPasswordAsync.fulfilled, (state, action) => {
                state.status = 'success';
                state.result = action.payload
                state.isCheck = 'email'
            }).addCase(resetPasswordAsync.rejected, (state) => {
                state.status = 'failed';
            })
    },
});

export const getResultFogot = (state: RootState) => state.forgotPassSate.result;

export default forgotPassSlice.reducer;

export const { checkOTP, resetDataForgot } = forgotPassSlice.actions;
