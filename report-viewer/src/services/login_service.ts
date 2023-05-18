import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { ModeFiveDto, ModeFourDto, ModeOneDto, ModeSixDto, ModeThreeDto, ModeTwoDto } from './sessions_service'

export interface LoginResponse {
    state: string
    stateDescription: string
    user: SimpleUser
    jwt: string
    roles: string[]
}

export interface SimpleUser {
    username: string
    group: string
    status: string
    createdBy: string
    createdDateTime: string
}

export interface CommonResponse {
    status: string
    statusDescription: string
}

export type PasswordValidationReportResponse = {
    status: string;
    statusDescription: string;
    modeId: number;
    modeOneDto: ModeOneDto | null;
    modeTwoDto: ModeTwoDto | null;
    modeThreeDto: ModeThreeDto | null;
    modeFourDto: ModeFourDto | null
    modeFiveDto: ModeFiveDto | null;
    modeSixDto: ModeSixDto | null;
}

export const loginApi = createApi({
    reducerPath: 'loginApi',
    baseQuery: fetchBaseQuery({ baseUrl: 'http://54.251.199.35/rvi-analyzer-api/' }),
    tagTypes: ['loginRequest'],
    endpoints: (build) => ({
        checkSession: build.query<CommonResponse, { hash: string }>({
            query: (hash) => `report/status/${hash.hash}`,
            providesTags: [{ type: 'loginRequest', id: "checkPassword" }]

        }),
        checkPassword: build.mutation<PasswordValidationReportResponse, { hash: string, password: string }>({
            query(data) {
                return {
                    url: `report/status/password/${data.hash}`,
                    method: 'POST',
                    body: { password: data.password },
                }
            },
        }),
    }),
})

export const {
    useCheckPasswordMutation,
    useCheckSessionQuery
} = loginApi