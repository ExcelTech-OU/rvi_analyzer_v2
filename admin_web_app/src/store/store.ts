import { configureStore } from '@reduxjs/toolkit'
import { dashboardApi } from '../services/dashboard_service'
import { deviceApi } from '../services/device_service'
import { loginApi } from '../services/login_service'
import { questionsApi } from '../services/question_service'
import { sessionApi } from '../services/sessions_service'
import { userApi } from '../services/user_service'
import { loginSlice } from '../views/auth/login/auth-slice'
import { signUpApi } from '../services/sign_up_service'
import { customerApi } from '../services/customer_service'
import { plantApi } from '../services/plant_service'
import { styleApi } from '../services/styles_service'
import { materialApi } from '../services/material_service'
import { testApi } from '../services/test_service'
import { parameterApi } from '../services/parameter_service'
import { gtTestingApi } from '../services/gt_service'
import { poApi } from '../services/po_service'
import { batteryApi } from '../services/battery_service'
import { gtTracking_userApi } from '../services/gtTracking_user_service'
import { shippingDetailsApi } from '../services/shippingDetails_service'

export const store = configureStore({
    reducer: {
        [loginApi.reducerPath]: loginApi.reducer,
        // [signUpApi.reducerPath]: signUpApi.reducer,
        [parameterApi.reducerPath]: parameterApi.reducer,
        [customerApi.reducerPath]: customerApi.reducer,
        [styleApi.reducerPath]: styleApi.reducer,
        [materialApi.reducerPath]: materialApi.reducer,
        [testApi.reducerPath]: testApi.reducer,
        [deviceApi.reducerPath]: deviceApi.reducer,
        [userApi.reducerPath]: userApi.reducer,
        [plantApi.reducerPath]: plantApi.reducer,
        [dashboardApi.reducerPath]: dashboardApi.reducer,
        [sessionApi.reducerPath]: sessionApi.reducer,
        [questionsApi.reducerPath]: questionsApi.reducer,
        [gtTestingApi.reducerPath]: gtTestingApi.reducer,
        [batteryApi.reducerPath]: batteryApi.reducer,
        [poApi.reducerPath]: poApi.reducer,
        [gtTracking_userApi.reducerPath]: gtTracking_userApi.reducer,
        [shippingDetailsApi.reducerPath]: shippingDetailsApi.reducer,
        loginStatus: loginSlice.reducer
    },
    middleware: (getDefaultMiddleware) =>
        getDefaultMiddleware().concat(loginApi.middleware)
            // .concat(signUpApi.middleware)
            .concat(parameterApi.middleware)
            .concat(plantApi.middleware)
            .concat(materialApi.middleware)
            .concat(customerApi.middleware)
            .concat(styleApi.middleware)
            .concat(testApi.middleware)
            .concat(deviceApi.middleware)
            .concat(userApi.middleware)
            .concat(dashboardApi.middleware)
            .concat(sessionApi.middleware)
            .concat(questionsApi.middleware)
            .concat(gtTestingApi.middleware)
            .concat(batteryApi.middleware)
            .concat(poApi.middleware)
            .concat(gtTracking_userApi.middleware)
            .concat(shippingDetailsApi.middleware),
})

// Infer the `RootState` and `AppDispatch` types from the store itself
export type RootState = ReturnType<typeof store.getState>
// Inferred type: {posts: PostsState, comments: CommentsState, users: UsersState}
export type AppDispatch = typeof store.dispatch