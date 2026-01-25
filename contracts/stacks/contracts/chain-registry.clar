;; AccessPass - NFT membership
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-ALREADY-MINTED (err u101))

(define-map passes
    { holder: principal }
    { tier: uint, minted-at: uint, active: bool }
)

(define-map admins { admin: principal } { is-admin: bool })

(define-public (mint (to principal) (tier uint))
    (begin
        (asserts! (default-to false (get is-admin (map-get? admins { admin: tx-sender }))) ERR-NOT-AUTHORIZED)
        (asserts! (is-none (map-get? passes { holder: to })) ERR-ALREADY-MINTED)
        (map-set passes { holder: to } { tier: tier, minted-at: block-height, active: true })
        (ok true)
    )
)

(define-read-only (has-access (user principal) (required-tier uint))
    (match (map-get? passes { holder: user })
        pass (and (get active pass) (>= (get tier pass) required-tier))
        false
    )
)

(define-read-only (get-pass (holder principal))
    (map-get? passes { holder: holder })
)
