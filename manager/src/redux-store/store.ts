import { configureStore, ThunkAction, Action } from '@reduxjs/toolkit';
import menuItemReducer from './menuItem-reducer/menuItemSlice';
import tableReducer from './table-reducer/tableSlice';
import orderReducer from './order-reducer/orderSlice';
import nhapHangReducer from './kho-reducer/nhapHangSlice';
import invoiceReducer from './invoice-reducer/invoiceSlice';
import checkinHistoryState from './checkin-history-redux/checkin-historySlice';
import userReducer from './user-reducer/userSlice';
import evenueReducer from './evenue-reducer/evenueSlice';
import authenticationReducer from './login-reducer/loginSlice';

export const store = configureStore({
  reducer: {
    menuItemState: menuItemReducer,
    tableState: tableReducer,
    orderState: orderReducer,
    invoiceState: invoiceReducer,
    nhapHangState: nhapHangReducer,
    checkinHistoryState: checkinHistoryState,
    userState: userReducer,
    evenueState: evenueReducer,
    authenticationState: authenticationReducer
  },
});

export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;
export type AppThunk<ReturnType = void> = ThunkAction<
  ReturnType,
  RootState,
  unknown,
  Action<string>
>;