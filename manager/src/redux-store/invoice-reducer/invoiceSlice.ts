import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState } from '../store';
import { api } from '../api';



export interface InvoiceSate {
    invoiceList: any[];
    invoiceDetailsList: any[];
    invoice: any;
    status: 'idle' | 'loading' | 'failed';
}

const initialState: InvoiceSate = {
    invoiceList: [],
    invoiceDetailsList: [],
    invoice: null,
    status: 'idle',
};

export const getInvoiceListAsync = createAsyncThunk(
    'invoice/get-list',
    async (page: number = 1) => {
        const token = localStorage.getItem('token');

        const response = await axios.get(api + '/api/invoice/list', {
            params: {
                page,
            },
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + token,
            },
        });

        return response.data;
    }
);
export const getSearchDateInvoiceListAsync = createAsyncThunk(
    'invoice/search-date-list',
    async (data: any) => {
        const token = localStorage.getItem('token');

        const response = await axios.get(api + '/api/invoice/search', {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + token,
            },
            params: {
                'endDate': data.endDate,
                'startDate': data.startDate
            }
        });

        return response.data;
    }
);
export const getDetailsInvoiceAsync = createAsyncThunk(
    'invoice/details',
    async (invoiceID: any) => {
        const token = localStorage.getItem('token');

        const response = await axios.get(api + '/api/invoice/details', {
            params: { invoiceID },
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + token,
            },
        });

        return response.data;
    }
);

const invoiceSlice = createSlice({
    name: 'invoice',
    initialState,
    reducers: {},

    extraReducers: (builder) => {
        builder
            .addCase(getInvoiceListAsync.pending, (state) => {
                state.status = 'loading';
            })
            .addCase(getInvoiceListAsync.fulfilled, (state, action) => {
                state.status = 'idle';
                state.invoiceList = action.payload;
            })
            .addCase(getInvoiceListAsync.rejected, (state) => {
                state.status = 'failed';
            }).addCase(getDetailsInvoiceAsync.pending, (state) => {
                state.status = 'loading';
            })
            .addCase(getDetailsInvoiceAsync.fulfilled, (state, action) => {
                state.status = 'idle';
                state.invoiceDetailsList = action.payload;
            })
            .addCase(getDetailsInvoiceAsync.rejected, (state) => {
                state.status = 'failed';
            })
            .addCase(getSearchDateInvoiceListAsync.fulfilled, (state, action) => {
                state.status = 'idle';
                state.invoiceList = action.payload;
            })
            .addCase(getSearchDateInvoiceListAsync.rejected, (state) => {
                state.status = 'failed';
            });
    },
});

export const getInvoiceList = (state: RootState) => state.invoiceState.invoiceList;
export const getInvoiceDetaiil = (state: RootState) => state.invoiceState.invoiceDetailsList;

export default invoiceSlice.reducer;
