import { configureStore } from '@reduxjs/toolkit'
import { dashboardApi } from '../services/dashboard_service'
import { deviceApi } from '../services/device_service'
import { loginApi } from '../services/login_service'
import { questionsApi } from '../services/question_service'
import { sessionApi } from '../services/sessions_service'
import { userApi } from '../services/user_service'
import { loginSlice } from '../views/auth/login/auth-slice'
import { signUpApi } from '../services/sign_up_service'

export const store = configureStore({
    reducer: {
        [loginApi.reducerPath]: loginApi.reducer,
        // [signUpApi.reducerPath]: signUpApi.reducer,
        [deviceApi.reducerPath]: deviceApi.reducer,
        [userApi.reducerPath]: userApi.reducer,
        [dashboardApi.reducerPath]: dashboardApi.reducer,
        [sessionApi.reducerPath]: sessionApi.reducer,
        [questionsApi.reducerPath]: questionsApi.reducer,
        loginStatus: loginSlice.reducer
    },
    middleware: (getDefaultMiddleware) =>
        getDefaultMiddleware().concat(loginApi.middleware)
            // .concat(signUpApi.middleware)
            .concat(deviceApi.middleware)
            .concat(userApi.middleware)
            .concat(dashboardApi.middleware)
            .concat(sessionApi.middleware)
            .concat(questionsApi.middleware),
})

// Infer the `RootState` and `AppDispatch` types from the store itself
export type RootState = ReturnType<typeof store.getState>
// Inferred type: {posts: PostsState, comments: CommentsState, users: UsersState}
export type AppDispatch = typeof store.dispatch