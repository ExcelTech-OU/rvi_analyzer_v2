import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'
import { Device } from './device_service'
import { User } from './user_service'

export interface UserTreatmentSessionListResponse {
    sessions: List<UserTreatmentSession>
}

export interface ModeOnesResponse {
    status: string
    statusDescription: string
    sessions: List<ModeOneDto>
    total: number
}

export interface ModeOneDto {
    createdBy: string
    defaultConfigurations: DefaultConfiguration
    sessionConfigurationModeOne: SessionConfigurationModeOne
    status: string
    results: List<SessionResult>
}

export interface DefaultConfiguration {
    customerName: string
    operatorId: string
    batchNo: string
    sessionId: string
}

export interface SessionConfigurationModeOne {
    voltage: string
    maxCurrent: string
    passMinCurrent: string
    passMaxCurrent: string
}

export interface SessionResult {
    testId: string
    readings: List<Reading>
}

export interface Reading {
    temperature: string
    current: string
    voltage: string
    readAt: string
    result: string
}

export interface ModeTwosResponse {
    status: string
    statusDescription: string
    sessions: List<ModeTwoDto>
    total: number
}

export interface ModeTwoDto {
    createdBy: string
    defaultConfigurations: DefaultConfiguration
    sessionConfigurationModeTwo: SessionConfigurationModeTwo
    status: string
    results: List<SessionResult>
}

export interface SessionConfigurationModeTwo {
    current: string
    maxVoltage: string
    passMinVoltage: string
    passMaxVoltage: string
}

export interface ModeThreesResponse {
    status: string
    statusDescription: string
    sessions: List<ModeThreeDto>
    total: number

}

export interface ModeThreeDto {
    createdBy: string
    defaultConfigurations: DefaultConfiguration
    sessionConfigurationModeThree: SessionConfigurationModeThree
    status: string
    results: SessionResult
}

export interface SessionConfigurationModeThree {
    startingVoltage: string
    desiredVoltage: string
    maxCurrent: string
    voltageResolution: string
    chargeInTime: string
}

export interface ModeFourResponse {
    status: string
    statusDescription: string
    sessions: List<ModeFourDto>
    total: number
}

export interface ModeFourDto {
    createdBy: string
    defaultConfigurations: DefaultConfiguration
    sessionConfigurationModeFour: SessionConfigurationModeFour
    status: string
    results: SessionResult
}

export interface SessionConfigurationModeFour {
    startingCurrent: string
    desiredCurrent: string
    maxVoltage: string
    currentResolution: string
    chargeInTime: string
}

export interface ModeFiveResponse {
    status: string
    statusDescription: string
    sessions: List<ModeFiveDto>
    total: number
}

export interface ModeFiveDto {
    createdBy: string
    defaultConfigurations: DefaultConfiguration
    sessionConfigurationModeFive: SessionConfigurationModeFive
    status: string
    results: SessionResult
}

export interface SessionConfigurationModeFive {
    fixedVoltage: string
    maxCurrent: string
    timeDuration: string
}

export interface ModeSixResponse {
    status: string
    statusDescription: string
    sessions: List<ModeSixDto>
    total: number
}

export interface ModeSixDto {
    createdBy: string
    defaultConfigurations: DefaultConfiguration
    sessionConfigurationModeSix: SessionConfigurationModeSix
    status: string
    results: SessionResult
}

export interface SessionConfigurationModeSix {
    fixedCurrent: string
    maxVoltage: string
    timeDuration: string
}


export interface UserTreatmentSession {
    id: string
    user_id: string
    device_id: string
    protocolId: string
    SelectedPainLevel: string
    SelectedTemperature: string
    initialSelectedTime: string
    initialBatteryLevel: string
    finalTemperature: string
    actualTreatmentTime: string
    endBatteryLevel: string
    feedbackPainLevel: string
    createdDate: string
    user: User
    device: Device
}

export interface GeneralResponse {
    state: string
    stateDescription: string
}

export type GetSessionFilters = {
    type: string
    id: string
}

export type GetSessionQuestionsResponse = {
    questionAnswers: Map<string, string>
}

export type ShareReportResponse = {
    status: string
    statusDescription: string
    url: string
    password: string
}

export const sessionApi = createApi({
    reducerPath: 'sessionApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'http://54.251.199.35/rvi-analyzer-api/',
        prepareHeaders: (headers) => {
            const token = localStorage.getItem("jwt") as string;
            if (!headers.has("Authorization") && token) {
                headers.set("Authorization", `Bearer ${token}`);
            }
            return headers;
        },
    }),
    tagTypes: ['sessions'],
    endpoints: (build) => ({
        getModeOneSessions: build.query<ModeOnesResponse, { data: {}, page: number }>({
            query(data) {
                return {
                    url: `rvi/analyzer/v1/session/get/one/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'sessions', id: "getModeOneSessions" }]

        }),
        getModeTwoSessions: build.query<ModeTwosResponse, { data: {}, page: number }>({
            query(data) {
                return {
                    url: `rvi/analyzer/v1/session/get/two/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'sessions', id: "getModeTwoSessions" }]

        }),
        getModeThreeSessions: build.query<ModeThreesResponse, { data: {}, page: number }>({
            query(data) {
                return {
                    url: `rvi/analyzer/v1/session/get/three/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'sessions', id: "getModeThreeSessions" }]

        }),
        getModeFourSessions: build.query<ModeFourResponse, { data: {}, page: number }>({
            query(data) {
                return {
                    url: `rvi/analyzer/v1/session/get/four/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'sessions', id: "getModeFourSessions" }]

        }),
        getModeFiveSessions: build.query<ModeFiveResponse, { data: {}, page: number }>({
            query(data) {
                return {
                    url: `rvi/analyzer/v1/session/get/five/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'sessions', id: "getModeFiveSessions" }]

        }),
        getModeSixSessions: build.query<ModeSixResponse, { data: {}, page: number }>({
            query(data) {
                return {
                    url: `rvi/analyzer/v1/session/get/six/${data.page}`,
                    method: 'POST',
                    body: data.data,
                }
            },
            providesTags: [{ type: 'sessions', id: "getModeSixSessions" }]

        }),
        getSessionQuestions: build.query<GetSessionQuestionsResponse, {}>({
            query(body) {
                return {
                    url: `user/sessions/feedback`,
                    method: 'POST',
                    body,
                }
            },
        }),
        shareReport: build.mutation<ShareReportResponse, { modeId: string, sessionId: string }>({
            query(data) {
                return {
                    url: `rvi/analyzer/v1/session/share/${data.modeId}/${data.sessionId}`,
                    method: 'GET',
                }
            },

        }),
    }),
})

export const {
    useGetSessionQuestionsQuery,
    useGetModeTwoSessionsQuery,
    useGetModeThreeSessionsQuery,
    useGetModeFourSessionsQuery,
    useGetModeFiveSessionsQuery,
    useGetModeSixSessionsQuery,
    useGetModeOneSessionsQuery,
    useShareReportMutation
} = sessionApi