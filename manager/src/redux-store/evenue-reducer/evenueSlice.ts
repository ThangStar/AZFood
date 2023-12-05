import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState, } from '../store';
import { api } from '../api';



export interface evenueState {
    evenueList: any[];
    evenueMonthList: any[];
    status: 'idle' | 'loading' | 'failed';
}

const initialState: evenueState = {
    evenueList: [],
    evenueMonthList: [],
    status: 'idle',
};

export const getEvenueListAsync = createAsyncThunk(
    'invoice/get-list',
    async () => {
        const token = localStorage.getItem('token');

        const response = await axios.get(api + '/api/stats/revenue-year', {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + token,
            },
        });

        return response.data;
    }
);
export const getEvenueMonthListAsync = createAsyncThunk(
    'invoice/get-month',
    async (month: any) => {
        const token = localStorage.getItem('token');
        console.log("api :: a", api);

        const response = await axios.get(api + '/api/stats/revenue-month', {
            params: { month },
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + token,
            },
        });

        return response.data;
    }
);
const evenueSlice = createSlice({
    name: 'invoice',
    initialState,
    reducers: {},

    extraReducers: (builder) => {
        builder
            .addCase(getEvenueListAsync.pending, (state) => {
                state.status = 'loading';
            })
            .addCase(getEvenueListAsync.fulfilled, (state, action) => {
                state.status = 'idle';
                state.evenueList = action.payload;
            })
            .addCase(getEvenueListAsync.rejected, (state) => {
                state.status = 'failed';
            })
            .addCase(getEvenueMonthListAsync.pending, (state) => {
                state.status = 'loading';
            })
            .addCase(getEvenueMonthListAsync.fulfilled, (state, action) => {
                state.status = 'idle';
                state.evenueMonthList = action.payload;
            })
            .addCase(getEvenueMonthListAsync.rejected, (state) => {
                state.status = 'failed';
            });

    },
});

export const getEvenueList = (state: RootState) => state.evenueState?.evenueList;
export const getEvenueMonthList = (state: RootState) => state.evenueState?.evenueMonthList;

export default evenueSlice.reducer;