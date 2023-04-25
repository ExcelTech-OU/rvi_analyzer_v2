import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'
import { GeneralResponse } from './device_service'

export interface UserListResponse {
    users: List<User>
}

export interface User {
    id: string
    name: string
    username: string
    email: string
    age: string
    occupation: string
    condition: string
    enabled: boolean
}

export const userApi = createApi({
    reducerPath: 'userApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'http://127.0.0.1:7550',
        prepareHeaders: (headers) => {
            const token = localStorage.getItem("jwt") as string;
            if (!headers.has("Authorization") && token) {
                headers.set("Authorization", `Bearer ${token}`);
            }
            return headers;
        },
    }),
    tagTypes: ['userList'],
    endpoints: (build) => ({
        getUsers: build.query<UserListResponse, {}>({
            query: () => `users`,
            providesTags: [{ type: 'userList', id: "getUsers" }]

        }),
        updateUser: build.mutation<GeneralResponse, {}>({
            query(body) {
                return {
                    url: `user/update`,
                    method: 'POST',
                    body,
                }
            },
            invalidatesTags: [{ type: 'userList', id: "getUsers" }]
        }),
    }),
})

export const {
    useGetUsersQuery,
    useUpdateUserMutation
} = userApi