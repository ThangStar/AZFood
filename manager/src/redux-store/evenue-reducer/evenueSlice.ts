import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState } from '../store';

const serverUrl = "http://localhost:8080";

export interface evenueState {
    evenueList: any[];
    status: 'idle' | 'loading' | 'failed';
}

const initialState: evenueState = {
    evenueList: [],
    status: 'idle',
};

export const getEvenueListAsync = createAsyncThunk(
    'invoice/get-list',
    async () => {
        const token = localStorage.getItem('token');

        const response = await axios.get(serverUrl + '/api/stats/revenue-year', {
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
            });

    },
});

export const getEvenueList = (state: RootState) => state.evenueState.evenueList;

export default evenueSlice.reducer;