import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'

export interface LoginResponse {
    state: string
    stateDescription: string
    user: SimpleUser
    jwt: string
    roles: string[]
}

export interface RolesResponse {
    status: string
    statusDescription: string
    user: SimpleUser
    roles: string[]
}

export interface SimpleUser {
    username: string
    group: string
    status: string
    createdBy: string
    createdDateTime: string
}

export const loginApi = createApi({
    reducerPath: 'loginApi',
    baseQuery: fetchBaseQuery({ baseUrl: 'http://rvi.v2.exceltch.com/rvi-analyzer-api/' }),
    tagTypes: ['loginRequest'],
    endpoints: (build) => ({
        login: build.mutation<LoginResponse, {}>({
            query(body) {
                return {
                    url: `login/user`,
                    method: 'POST',
                    body,
                }
            },
        }),
    }),
})

export const {
    useLoginMutation
} = loginApi