import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState } from '../store';

const serverUrl = "http://localhost:8080";

export interface InvoiceSate {
    checkinHistoryList: any[];
    checkinHistory: any;
    status: 'idle' | 'loading' | 'failed';
}

const initialState: InvoiceSate = {
    checkinHistoryList: [],
    checkinHistory: null,
    status: 'idle',
};

export const getCheckinHistoryListAsync = createAsyncThunk(
    'checkin-history',
    async () => {
        const token = localStorage.getItem('token');

        const response = await axios.get(serverUrl + '/api/attendance/list', {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + token,
            },
        });

        return response.data;
    }
);

const addtendanceSlice = createSlice({
    name: 'checkin-history',
    initialState,
    reducers: {},

    extraReducers: (builder) => {
        builder
            .addCase(getCheckinHistoryListAsync.pending, (state) => {
                state.status = 'loading';
            })
            .addCase(getCheckinHistoryListAsync.fulfilled, (state, action) => {
                state.status = 'idle';
                state.checkinHistoryList = action.payload;
            }).addCase(getCheckinHistoryListAsync.rejected, (state) => {
                state.status = 'failed';
            })

    },
});

export const getCheckinHistoryList = (state: RootState) => state.checkinHistoryState.checkinHistoryList;

export default addtendanceSlice.reducer;
